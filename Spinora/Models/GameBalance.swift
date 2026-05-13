import Foundation

enum GameBalance {
    static let startingPlayerHP = 100
    static let startingPlayerDamage = 12
    static let startingRollsPerTurn = 3

    static func monsterHP(stage: Int, isBoss: Bool = false) -> Int {
        let baseHP = 50 + (stage * 10)
        return isBoss ? Int(Double(baseHP) * 1.8) : baseHP
    }

    static func monsterAttack(stage: Int, isBoss: Bool = false) -> Int {
        let baseAttack = 5 + (stage * 2)
        return isBoss ? Int(Double(baseAttack) * 1.5) : baseAttack
    }

    static func rewardCoins(stage: Int) -> Int {
        10 + (stage * 3)
    }
}
