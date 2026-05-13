import Foundation
import SwiftData

@Model
final class SavedRunModel {
    @Attribute(.unique) var runID: UUID
    var stage: Int
    var playerHP: Int
    var playerMaxHP: Int
    var playerDamage: Int
    var coins: Int
    var monsterName: String
    var monsterElementRawValue: String
    var monsterHP: Int
    var monsterMaxHP: Int
    var updatedAt: Date

    init(
        runID: UUID = UUID(),
        stage: Int,
        playerHP: Int,
        playerMaxHP: Int,
        playerDamage: Int,
        coins: Int,
        monsterName: String,
        monsterElementRawValue: String,
        monsterHP: Int,
        monsterMaxHP: Int,
        updatedAt: Date = Date()
    ) {
        self.runID = runID
        self.stage = stage
        self.playerHP = playerHP
        self.playerMaxHP = playerMaxHP
        self.playerDamage = playerDamage
        self.coins = coins
        self.monsterName = monsterName
        self.monsterElementRawValue = monsterElementRawValue
        self.monsterHP = monsterHP
        self.monsterMaxHP = monsterMaxHP
        self.updatedAt = updatedAt
    }
}
