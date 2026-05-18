//
//  ComboEffect.swift
//  Spinora
//

import Foundation

enum ComboEffect {
    case none
    case double
    case triple

    var displayName: String {
        switch self {
        case .none:   return ""
        case .double: return "DOUBLE COMBO!"
        case .triple: return "TRIPLE COMBO!"
        }
    }
}
