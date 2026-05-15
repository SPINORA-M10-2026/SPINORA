import Foundation
import SwiftData

@Model
final class Enemy {
    @Attribute(.unique) var id: UUID
    var name: String
    var element: String
    var hp: Int
    var maxHP: Int
    var atk: Float
    var isBoss: Bool
    var waveNumber: Int

    @Relationship var savedRun: SavedRun?

    init(
        id: UUID = UUID(),
        name: String,
        element: String,
        hp: Int,
        maxHP: Int,
        atk: Float,
        isBoss: Bool = false,
        waveNumber: Int
    ) {
        self.id = id
        self.name = name
        self.element = element
        self.hp = hp
        self.maxHP = maxHP
        self.atk = atk
        self.isBoss = isBoss
        self.waveNumber = waveNumber
    }
}
