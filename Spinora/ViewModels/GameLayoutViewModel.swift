//
//  GameLayoutViewModel.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//


//
//  GameLayoutViewModel.swift
//  Spinora
//

import Foundation

@MainActor
final class GameLayoutViewModel: ObservableObject {
    @Published var layoutData: BattleLayoutData = .preview
    @Published var overlay: GameOverlayType? = nil
    @Published var confirmAction: ConfirmAction? = nil

    private let reelManager = ReelManager()

    private var symbols: [Element] = [.water, .fire, .earth]
    private var rolledThisTurn: [Bool] = [false, false, false]
    private var isRolling: Bool = false

    private let maxRollsPerTurn = 3

    init() {
        startNewTurn()
    }

    // MARK: - Turn

    func startNewTurn() {
        let reelState = reelManager.makeNewTurnState(count: 3)

        symbols = reelState.symbols
        rolledThisTurn = reelState.rolledThisTurn
        isRolling = reelState.isRolling

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

        let newState = reelManager.commitRoll(
            result: result,
            symbols: symbols,
            rolledThisTurn: rolledThisTurn
        )

        symbols = newState.symbols
        rolledThisTurn = newState.rolledThisTurn
        isRolling = newState.isRolling

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
        max(0, maxRollsPerTurn - reelManager.usedRollCount(rolledThisTurn))
    }

    private func makeReelColumns() -> [[String]] {
        symbols.map { centerSymbol in
            [
                decorativeSymbol(excluding: centerSymbol).rawValue,
                centerSymbol.rawValue,
                decorativeSymbol(excluding: centerSymbol).rawValue
            ]
        }
    }

    private func decorativeSymbol(excluding symbol: Element) -> Element {
        let options = Element.allCases.filter { $0 != symbol }
        return options.randomElement() ?? symbol
    }

    // MARK: - Attack Demo

    func attack() {
        guard layoutData.canAttack else {
            return
        }

        let damage = 20
        layoutData.enemyHP = max(0, layoutData.enemyHP - damage)

        if layoutData.enemyHP <= 0 {
            showWaveCleared()
        } else {
            startNewTurn()
        }
    }

    // MARK: - Overlay

    func showWaveCleared() {
        overlay = .waveCleared
    }

    func showPause() {
        overlay = .pause
    }

    func showRestartWaveConfirmation() {
        confirmAction = .restartWave
        overlay = .confirmation
    }

    func showResetGameConfirmation() {
        confirmAction = .resetGame
        overlay = .confirmation
    }

    func closeOverlay() {
        overlay = nil
        confirmAction = nil
        syncLayout()
    }

    func backToPause() {
        overlay = .pause
        confirmAction = nil
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

    func openInventory() {
        print("Inventory tapped")
    }

    // MARK: - Wave / Reset

    private func nextWave() {
        let currentWave = Int(layoutData.waveText) ?? 1
        let nextWave = currentWave + 1

        layoutData.waveText = String(format: "%03d", nextWave)
        layoutData.enemyHP = layoutData.enemyMaxHP
        overlay = nil
        confirmAction = nil

        startNewTurn()
    }

    private func restartWave() {
        layoutData.enemyHP = layoutData.enemyMaxHP
        layoutData.playerHP = layoutData.playerMaxHP
        startNewTurn()
    }

    private func resetGame() {
        layoutData = .preview
        symbols = [.water, .fire, .earth]
        rolledThisTurn = [false, false, false]
        isRolling = false
        startNewTurn()
    }

    // MARK: - Sync

    private func syncLayout() {
        layoutData.rerollText = "↻ \(remainingRollCount())/3"
        layoutData.reelColumns = makeReelColumns()
        layoutData.reelRolledThisTurn = rolledThisTurn
        layoutData.canAttack = !isRolling && overlay == nil
    }
}