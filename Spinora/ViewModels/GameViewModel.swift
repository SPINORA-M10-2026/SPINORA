import Combine
import Foundation
import SwiftData

@MainActor
final class GameViewModel: ObservableObject {
    @Published private(set) var stage: Int = 1
    @Published private(set) var playerHP: Int = GameBalance.startingPlayerHP
    @Published private(set) var playerMaxHP: Int = GameBalance.startingPlayerHP
    @Published private(set) var playerDamage: Int = GameBalance.startingPlayerDamage
    @Published private(set) var coins: Int = 0
    @Published private(set) var selectedElement: Element?
    @Published private(set) var monster: Monster
    @Published private(set) var lastCombatSummary: CombatSummary?
    @Published private(set) var battleMessage: String = "Roll to choose an element."

    private let reelManager: ReelManager
    private let combatManager: CombatManager
    private let stageManager: StageManager
    private let upgradeManager: UpgradeManager
    private var modelContext: ModelContext?

    init(
        reelManager: ReelManager? = nil,
        combatManager: CombatManager? = nil,
        stageManager: StageManager? = nil,
        upgradeManager: UpgradeManager? = nil,
        modelContext: ModelContext? = nil
    ) {
        let stageManager = stageManager ?? StageManager()

        self.reelManager = reelManager ?? ReelManager()
        self.combatManager = combatManager ?? CombatManager()
        self.stageManager = stageManager
        self.upgradeManager = upgradeManager ?? UpgradeManager()
        self.modelContext = modelContext
        self.monster = stageManager.generateMonster(stage: 1)
    }

    var remainingRolls: Int {
        reelManager.remainingRolls
    }

    func setModelContext(_ modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func rollElement() {
        guard let element = reelManager.roll() else {
            battleMessage = "No rolls remaining."
            return
        }

        selectedElement = element
        battleMessage = "Rolled \(element.rawValue)."
    }

    func attack() {
        guard let selectedElement else {
            battleMessage = "Roll before attacking."
            return
        }

        let result = combatManager.resolveAttack(
            playerElement: selectedElement,
            monster: monster,
            playerDamage: playerDamage,
            playerHP: playerHP
        )

        monster = result.monster
        playerHP = result.playerHP
        lastCombatSummary = result.summary
        battleMessage = result.summary.message

        if result.summary.didDefeatMonster {
            advanceStage()
        } else {
            reelManager.resetRolls()
            self.selectedElement = nil
        }
    }

    func availableUpgradeOptions() -> [UpgradeOption] {
        upgradeManager.generateUpgradeOptions()
    }

    private func advanceStage() {
        coins += stageManager.rewardCoins(stage: stage)
        stage += 1
        monster = stageManager.generateMonster(stage: stage)
        reelManager.resetRolls()
        selectedElement = nil
        battleMessage = "Stage \(stage) started."
    }
}
