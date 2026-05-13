import Foundation

struct UpgradeOption: Identifiable, Codable, Equatable {
    enum Kind: String, Codable, CaseIterable {
        case damage
        case maxHP
        case heal
        case extraRoll
    }

    let id: UUID
    var title: String
    var kind: Kind
    var value: Int

    init(id: UUID = UUID(), title: String, kind: Kind, value: Int) {
        self.id = id
        self.title = title
        self.kind = kind
        self.value = value
    }
}
