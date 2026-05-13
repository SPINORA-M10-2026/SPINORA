import Foundation
import SwiftData

@Model
final class PlayerProfileModel {
    @Attribute(.unique) var playerID: UUID
    var totalRuns: Int
    var highestStage: Int
    var lifetimeCoins: Int

    init(playerID: UUID = UUID(), totalRuns: Int = 0, highestStage: Int = 1, lifetimeCoins: Int = 0) {
        self.playerID = playerID
        self.totalRuns = totalRuns
        self.highestStage = highestStage
        self.lifetimeCoins = lifetimeCoins
    }
}
