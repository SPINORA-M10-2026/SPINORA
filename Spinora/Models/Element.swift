import Foundation

enum Element: String, CaseIterable, Codable {
    case air
    case api
    case tanah

    var emoji: String {
        switch self {
        case .air:   return "💧"
        case .api:   return "🔥"
        case .tanah: return "🪨"
        }
    }
}
