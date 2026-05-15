import Foundation
import SwiftData

@Model
final class Jackpot {
    @Attribute(.unique) var id: UUID
    var element: String
    var bonusMultiplier: Float
    var effectType: String

    @Relationship var roll: Roll?

    init(
        id: UUID = UUID(),
        element: String,
        bonusMultiplier: Float = 2.0,
        effectType: String = "damage"
    ) {
        self.id = id
        self.element = element
        self.bonusMultiplier = bonusMultiplier
        self.effectType = effectType
    }
}
