import Foundation

enum Element: String, Codable, CaseIterable, Identifiable {
    case fire
    case water
    case earth

    var id: String { rawValue }
}
