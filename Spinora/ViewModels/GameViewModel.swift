//
//  GameViewModel.swift
//  Spinora
//

import Foundation
import Combine

@MainActor
final class GameViewModel: ObservableObject {

    // MARK: - Published State

    @Published var player: Character
    @Published var monster: Character
    @Published var reelState: ReelState
    @Published var isGameOver: Bool = false
    @Published var isRolling: Bool = false
    @Published var battleMessage: String = ""
    @Published var currentWave: Int = 1
    @Published var overlay: GameOverlayType? = nil
    @Published var confirmAction: ConfirmAction? = nil

    // MARK: - Systems

    private let combatManager = CombatManager()
    private let reelManager: ReelManager

    // MARK: - Persistence (injected by ContentView via ModelContext)

    var savedRunRepository: SavedRunRepository?
    var runHistoryRepository: RunHistoryRepository?

    // MARK: - Init

    init(reelManager: ReelManager = ReelManager()) {
        self.reelManager = reelManager
        self.player = Character(hp: 100, maxHp: 100, baseAttack: 20, element: nil)
        self.monster = Self.makeMonster(wave: 1)
        self.reelState = reelManager.makeNewTurnState()
    }

    // MARK: - Reel

    func rollReel(at index: Int) {
        guard let result = reelManager.createRollResult(
            index: index,
            rolledThisTurn: reelState.rolledThisTurn,
            isRolling: isRolling,
            isGameOver: isGameOver,
            showingUpgradeSheet: overlay != nil
        ) else { return }

        isRolling = true

        Task {
            try? await Task.sleep(nanoseconds: UInt64(result.duration * 1_000_000_000))
            reelState = reelManager.commitRoll(
                result: result,
                symbols: reelState.symbols,
                rolledThisTurn: reelState.rolledThisTurn
            )
            isRolling = false
        }
    }

    // MARK: - Combat

    func attack() {
        guard !isGameOver, overlay == nil, !isRolling else { return }

        let (updatedPlayer, updatedMonster, summary) = combatManager.resolveAttack(
            player: player,
            monster: monster,
            reelState: reelState
        )

        player = updatedPlayer
        monster = updatedMonster
        battleMessage = summary.battleMessage

        if summary.isMonsterDead {
            handleWaveCleared()
        } else if summary.isPlayerDead {
            handleGameOver()
        } else {
            reelState = reelManager.makeNewTurnState()
        }
    }

    // MARK: - Wave / Game Flow

    private func handleWaveCleared() {
        overlay = .waveCleared
        saveRun()
        appendHistory(outcome: .victory)
    }

    private func handleGameOver() {
        isGameOver = true
        appendHistory(outcome: .defeat)
        clearSavedRun()
    }

    func selectReward(_ reward: RewardChoice) {
        switch reward {
        case .hp:
            let bonus = max(1, Int(Double(player.maxHp) * 0.1))
            player.maxHp += bonus
            player.hp = min(player.hp + bonus, player.maxHp)
        case .attack:
            player.baseAttack = max(1, Int(Double(player.baseAttack) * 1.1))
        }
        advanceWave()
    }

    private func advanceWave() {
        currentWave += 1
        monster = Self.makeMonster(wave: currentWave)
        reelState = reelManager.makeNewTurnState()
        overlay = nil
    }

    func restartWave() {
        monster = Self.makeMonster(wave: currentWave)
        reelState = reelManager.makeNewTurnState()
        isGameOver = false
        overlay = nil
        battleMessage = ""
    }

    func resetGame() {
        currentWave = 1
        player = Character(hp: 100, maxHp: 100, baseAttack: 20, element: nil)
        monster = Self.makeMonster(wave: 1)
        reelState = reelManager.makeNewTurnState()
        isGameOver = false
        overlay = nil
        battleMessage = ""
        clearSavedRun()
    }

    // MARK: - Overlay

    func showPause() { overlay = .pause }

    func closeOverlay() {
        overlay = nil
        confirmAction = nil
    }

    func backToPause() {
        overlay = .pause
        confirmAction = nil
    }

    func showRestartWaveConfirmation() {
        confirmAction = .restartWave
        overlay = .confirmation
    }

    func showResetGameConfirmation() {
        confirmAction = .resetGame
        overlay = .confirmation
    }

    func confirmCurrentAction() {
        switch confirmAction {
        case .restartWave: restartWave()
        case .resetGame:   resetGame()
        case .none:        break
        }
        closeOverlay()
    }

    // MARK: - Save / Load

    func saveRun() {
        guard let repo = savedRunRepository else { return }
        let model = SavedRunMapper.toModel(wave: currentWave, player: player)
        try? repo.save(model)
    }

    func loadRun() {
        guard let repo = savedRunRepository,
              let model = try? repo.load() else { return }
        let state = SavedRunMapper.toGameState(from: model)
        currentWave = state.wave
        player = state.player
        monster = Self.makeMonster(wave: currentWave)
        reelState = reelManager.makeNewTurnState()
        battleMessage = ""
        isGameOver = false
        overlay = nil
    }

    private func clearSavedRun() {
        try? savedRunRepository?.delete()
    }

    private func appendHistory(outcome: RunOutcome) {
        guard let repo = runHistoryRepository else { return }
        let model = RunHistoryMapper.toModel(wave: currentWave, player: player, outcome: outcome)
        try? repo.append(model)
    }

    // MARK: - Monster Factory
    // Coordinate with Person 2 (Balance) before adjusting scaling numbers

    private static func makeMonster(wave: Int) -> Character {
        let hp  = 50 + wave * 20
        let atk = 8  + wave * 3
        let element = Element.allCases[wave % Element.allCases.count]
        return Character(hp: hp, maxHp: hp, baseAttack: atk, element: element)
    }
}
