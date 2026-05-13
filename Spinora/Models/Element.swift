//
//  Element.swift
//  Spinora
//
//  Created by Stanley Young on 13/05/26.
//

import Foundation

enum Element: String, CaseIterable, Identifiable {
    case fire = "🔥"
    case water = "💧"
    case earth = "🪨"

    var id: String {
        rawValue
    }

    var name: String {
        switch self {
        case .fire:
            return "Fire"
        case .water:
            return "Water"
        case .earth:
            return "Earth"
        }
    }

    func beats(_ other: Element) -> Bool {
        switch (self, other) {
        case (.fire, .earth),
             (.earth, .water),
             (.water, .fire):
            return true
        default:
            return false
        }
    }

    func weakAgainst(_ other: Element) -> Bool {
        other.beats(self)
    }
}
