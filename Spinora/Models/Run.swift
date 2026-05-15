import Foundation
import SwiftData

@Model
final class RunHistory {
    @Attribute(.unique) var id: UUID
    var finalWave: Int
    var enemiesDefeated: Int
    var totalDamageDealt: Int
    var totalSpins: Int
    var duration: Float
    var victory: Bool
    var completedAt: Date

    @Relationship var player: Player?
    @Relationship var savedRun: SavedRun?

    init(
        id: UUID = UUID(),
        finalWave: Int,
        enemiesDefeated: Int,
        totalDamageDealt: Int,
        totalSpins: Int,
        duration: Float,
        victory: Bool,
        completedAt: Date = .now
    ) {
        self.id = id
        self.finalWave = finalWave
        self.enemiesDefeated = enemiesDefeated
        self.totalDamageDealt = totalDamageDealt
        self.totalSpins = totalSpins
        self.duration = duration
        self.victory = victory
        self.completedAt = completedAt
    }
}
