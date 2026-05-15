import Foundation
import SwiftData

@Model
final class WaveState {
    @Attribute(.unique) var id: UUID
    var waveNumber: Int
    var isCleared: Bool
    var reelsReset: Bool
    var enemyGenerated: Bool
    var rewardPicked: Bool
    var playerHealed: Bool
    var healAmount: Float
    var clearedAt: Date?

    @Relationship var savedRun: SavedRun?
    @Relationship(deleteRule: .cascade) var rewardPick: RewardPick?

    init(
        id: UUID = UUID(),
        waveNumber: Int,
        isCleared: Bool = false,
        reelsReset: Bool = false,
        enemyGenerated: Bool = false,
        rewardPicked: Bool = false,
        playerHealed: Bool = false,
        healAmount: Float = 0
    ) {
        self.id = id
        self.waveNumber = waveNumber
        self.isCleared = isCleared
        self.reelsReset = reelsReset
        self.enemyGenerated = enemyGenerated
        self.rewardPicked = rewardPicked
        self.playerHealed = playerHealed
        self.healAmount = healAmount
    }
}
