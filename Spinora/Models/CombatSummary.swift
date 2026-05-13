import Foundation

struct CombatSummary: Codable, Equatable {
    var playerElement: Element
    var monsterElement: Element
    var playerDamage: Int
    var monsterDamage: Int
    var comboEffect: ComboEffect?
    var didDefeatMonster: Bool
    var didPlayerDie: Bool
    var message: String
}
