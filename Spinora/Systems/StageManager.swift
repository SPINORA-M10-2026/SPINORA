import Foundation

final class StageManager {
    func generateMonster(stage: Int) -> Monster {
        let isBoss = stage > 0 && stage.isMultiple(of: 5)
        let element = Element.allCases[stage % Element.allCases.count]

        return Monster(
            name: isBoss ? "Furnace Boss" : "Furnace Monster",
            element: element,
            maxHP: GameBalance.monsterHP(stage: stage, isBoss: isBoss),
            attack: GameBalance.monsterAttack(stage: stage, isBoss: isBoss),
            stage: stage,
            isBoss: isBoss
        )
    }

    func rewardCoins(stage: Int) -> Int {
        GameBalance.rewardCoins(stage: stage)
    }
}
