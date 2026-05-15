import Foundation
import SwiftData

@Model
final class SavedRun {
    @Attribute(.unique) var id: UUID
    var currentWave: Int
    var playerHP: Int
    var playerMaxHP: Int
    var playerATK: Float
    var isActive: Bool
    var createdAt: Date
    var updatedAt: Date

    @Relationship var player: Player?
    @Relationship(deleteRule: .cascade) var rolls: [Roll]
    @Relationship(deleteRule: .cascade) var enemies: [Enemy]
    @Relationship(deleteRule: .cascade) var waveStates: [WaveState]
    @Relationship(deleteRule: .cascade) var rewardPicks: [RewardPick]
    @Relationship(deleteRule: .cascade) var runHistory: RunHistory?

    init(
        id: UUID = UUID(),
        currentWave: Int = 1,
        playerHP: Int = 100,
        playerMaxHP: Int = 100,
        playerATK: Float = 10.0,
        isActive: Bool = true,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.currentWave = currentWave
        self.playerHP = playerHP
        self.playerMaxHP = playerMaxHP
        self.playerATK = playerATK
        self.isActive = isActive
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.rolls = []
        self.enemies = []
        self.waveStates = []
        self.rewardPicks = []
    }
}
