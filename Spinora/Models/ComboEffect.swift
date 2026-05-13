import Foundation

struct ComboEffect: Codable, Equatable {
    enum Kind: String, Codable {
        case bonusDamage
        case heal
        case shield
    }

    var kind: Kind
    var value: Int
    var description: String
}
