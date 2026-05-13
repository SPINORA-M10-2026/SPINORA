import Foundation

struct Monster: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var element: Element
    var maxHP: Int
    var currentHP: Int
    var attack: Int
    var stage: Int
    var isBoss: Bool

    init(
        id: UUID = UUID(),
        name: String,
        element: Element,
        maxHP: Int,
        currentHP: Int? = nil,
        attack: Int,
        stage: Int,
        isBoss: Bool = false
    ) {
        self.id = id
        self.name = name
        self.element = element
        self.maxHP = maxHP
        self.currentHP = currentHP ?? maxHP
        self.attack = attack
        self.stage = stage
        self.isBoss = isBoss
    }
}
