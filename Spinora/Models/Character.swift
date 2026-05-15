import Foundation
import SwiftData

// MARK: - Character (gameplay value type, digunakan GameViewModel)

struct Character {
    var hp: Int
    var maxHp: Int
    var baseAttack: Int
    var element: Element?

    var isDead: Bool { hp <= 0 }

    mutating func takeDamage(_ amount: Int) {
        hp = max(0, hp - amount)
    }
}

// MARK: - Player (SwiftData persistence, menyimpan statistik antar-run)

@Model
final class Player {
    @Attribute(.unique) var id: UUID
    var name: String
    var totalRuns: Int
    var bestWave: Int
    var totalEnemiesDefeated: Int
    var createdAt: Date

    @Relationship(deleteRule: .cascade) var settings: GameSettings?
    @Relationship(deleteRule: .cascade) var savedRuns: [SavedRun]
    @Relationship(deleteRule: .cascade) var runHistories: [RunHistory]

    init(
        id: UUID = UUID(),
        name: String = "Player",
        totalRuns: Int = 0,
        bestWave: Int = 0,
        totalEnemiesDefeated: Int = 0,
        createdAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.totalRuns = totalRuns
        self.bestWave = bestWave
        self.totalEnemiesDefeated = totalEnemiesDefeated
        self.createdAt = createdAt
        self.savedRuns = []
        self.runHistories = []
    }
}
