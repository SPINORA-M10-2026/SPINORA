//
//  Element.swift
//  SPINORA
//
//  Created by oky faishal on 12/05/26.
//

import Foundation

enum Element: String, CaseIterable {
    case air = "Air"
    case api = "Api"
    case tanah = "Tanah"
    
    // Properti untuk mempermudah View menggambar UI
    var emoji: String {
        switch self {
        case .air: return "💧"
        case .api: return "🔥"
        case .tanah: return "🪨"
        }
    }
    
    // Logika murni: Air > Api > Tanah > Air
    // Mengembalikan pengali damage (2.0 jika kuat, 0.5 jika lemah, 1.0 jika sama)
    func damageMultiplier(against enemyElement: Element) -> Double {
        if self == enemyElement { return 1.0 }
        
        switch (self, enemyElement) {
        case (.air, .api), (.api, .tanah), (.tanah, .air):
            return 2.0 // Super Effective
        default:
            return 0.5 // Not Effective
        }
    }
}
