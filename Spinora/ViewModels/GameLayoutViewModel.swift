//
//  GameLayoutViewModel.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import Foundation
import Combine

@MainActor
final class GameLayoutViewModel: ObservableObject {
    @Published var layoutData: BattleLayoutData = .preview
    @Published var overlay: GameOverlayType? = nil
    @Published var confirmAction: ConfirmAction? = nil
    @Published var playerAnimationState: PlayerAnimationState = .idle
    @Published var enemyAppearance: EnemyAppearance = EnemyAppearance.random()

    private let reelManager = ReelManager()

    private var symbols: [Element] = [.water, .fire, .earth]
    private var rolledThisTurn: [Bool] = [false, false, false]
    private var isRolling: Bool = false

    private var currentReelColumns: [[String]] = [
        ["💧", "🔥", "🔥"],
        ["🔥", "💧", "🪨"],
        ["🪨", "🪨", "💧"]
    ]

    private let maxRollsPerTurn = 3
    private let attackDamage = 20

    init() {
        startNewTurn()
    }

    // MARK: - Turn

    func startNewTurn() {
        let reelState = reelManager.makeNewTurnState(count: 3)

        symbols = reelState.symbols
        rolledThisTurn = reelState.rolledThisTurn
        isRolling = reelState.isRolling

        layoutData.lastRolledIndex = nil
        currentReelColumns = makeAllReelColumns()

        syncLayout()
    }

    // MARK: - Reel

    func rollReel(index: Int) {
        guard overlay == nil else {
            return
        }

        guard let result = reelManager.createRollResult(
            index: index,
            rolledThisTurn: rolledThisTurn,
            isRolling: isRolling,
            isGameOver: false,
            showingUpgradeSheet: false
        ) else {
            return
        }

        isRolling = true
        layoutData.lastRolledIndex = nil
        syncLayout()

        let newState = reelManager.commitRoll(
            result: result,
            symbols: symbols,
            rolledThisTurn: rolledThisTurn
        )

        symbols = newState.symbols
        rolledThisTurn = newState.rolledThisTurn
        isRolling = newState.isRolling

        updateOnlyRolledReelColumn(index: index)
        layoutData.lastRolledIndex = index

        syncLayout()
    }

    func canRollReel(index: Int) -> Bool {
        reelManager.canRoll(
            index: index,
            rolledThisTurn: rolledThisTurn,
            isRolling: isRolling,
            isGameOver: false,
            showingUpgradeSheet: overlay != nil
        )
    }

    private func remainingRollCount() -> Int {
        let usedRollCount = reelManager.usedRollCount(rolledThisTurn)
        return max(0, maxRollsPerTurn - usedRollCount)
    }

    // MARK: - Reel Column Generation

    private func makeAllReelColumns() -> [[String]] {
        symbols.map { centerSymbol in
            makeReelColumn(centerSymbol: centerSymbol)
        }
    }

    private func updateOnlyRolledReelColumn(index: Int) {
        guard index >= 0 else {
            return
        }

        guard index < symbols.count else {
            return
        }

        guard index < currentReelColumns.count else {
            return
        }

        currentReelColumns[index] = makeReelColumn(centerSymbol: symbols[index])
    }

    private func makeReelColumn(centerSymbol: Element) -> [String] {
        [
            decorativeSymbol(excluding: centerSymbol).rawValue,
            centerSymbol.rawValue,
            decorativeSymbol(excluding: centerSymbol).rawValue
        ]
    }

    private func decorativeSymbol(excluding symbol: Element) -> Element {
        let options = Element.allCases.filter { $0 != symbol }
        return options.randomElement() ?? symbol
    }

    // MARK: - Attack

    func attack() {
        guard layoutData.canAttack else { return }
        guard overlay == nil else { return }

        playerAnimationState = .attack
        Task {
            try? await Task.sleep(nanoseconds: 600_000_000)
            playerAnimationState = .idle
        }

        layoutData.enemyHP = max(0, layoutData.enemyHP - attackDamage)

        if layoutData.enemyHP <= 0 {
            showWaveCleared()
        } else {
            startNewTurn()
        }
    }

    // MARK: - Overlay

    func showWaveCleared() {
        overlay = .waveCleared
        syncLayout()
    }

    func showPause() {
        overlay = .pause
        syncLayout()
    }

    func showRestartWaveConfirmation() {
        confirmAction = .restartWave
        overlay = .confirmation
        syncLayout()
    }

    func showResetGameConfirmation() {
        confirmAction = .resetGame
        overlay = .confirmation
        syncLayout()
    }

    func closeOverlay() {
        overlay = nil
        confirmAction = nil
        syncLayout()
    }

    func backToPause() {
        overlay = .pause
        confirmAction = nil
        syncLayout()
    }

    func selectReward(_ reward: RewardChoice) {
        switch reward {
        case .hp:
            layoutData.playerMaxHP += 10
            layoutData.playerHP = min(layoutData.playerMaxHP, layoutData.playerHP + 10)

        case .attack:
            layoutData.playerAttackText = "89.90"
        }

        nextWave()
    }

    func confirmCurrentAction() {
        switch confirmAction {
        case .restartWave:
            restartWave()

        case .resetGame:
            resetGame()

        case .none:
            break
        }

        closeOverlay()
    }

    func openGuidebook() {
        print("Guidebook tapped")
    }

    // MARK: - Wave / Reset

    private func nextWave() {
        let currentWave = Int(layoutData.waveText) ?? 1
        let nextWave = currentWave + 1

        layoutData.waveText = String(format: "%03d", nextWave)
        layoutData.enemyHP = layoutData.enemyMaxHP
        enemyAppearance = EnemyAppearance.random()

        overlay = nil
        confirmAction = nil

        startNewTurn()
    }

    private func restartWave() {
        layoutData.enemyHP = layoutData.enemyMaxHP
        layoutData.playerHP = layoutData.playerMaxHP

        overlay = nil
        confirmAction = nil

        startNewTurn()
    }

    private func resetGame() {
        layoutData = .preview
        symbols = [.water, .fire, .earth]
        rolledThisTurn = [false, false, false]
        isRolling = false
        enemyAppearance = EnemyAppearance.random()

        currentReelColumns = [
            ["💧", "🔥", "🔥"],
            ["🔥", "💧", "🪨"],
            ["🪨", "🪨", "💧"]
        ]

        overlay = nil
        confirmAction = nil

        startNewTurn()
    }

    // MARK: - Sync

    private func syncLayout() {
        layoutData.rerollText = "↻ \(remainingRollCount())/3"
        layoutData.reelColumns = currentReelColumns
        layoutData.reelRolledThisTurn = rolledThisTurn
        layoutData.canAttack = !isRolling && overlay == nil
    }
}
