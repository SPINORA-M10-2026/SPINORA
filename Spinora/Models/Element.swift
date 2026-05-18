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
    
    func damageMultiplier(against enemyElement: Element) -> Double {
        if self == enemyElement {
            return 1.0
        }

        switch (self, enemyElement) {
        case (.water, .fire),
             (.fire, .earth),
             (.earth, .water):
            return 2.0
        default:
            return 0.5
        }
    }}
