//
//  Constants.swift
//  SPINORA
//
//  Created by oky faishal on 12/05/26.
//

import Foundation
import CoreGraphics

struct GameConstants {
    
    struct GamePlay {
        static let maxRerolls: Int = 3
        static let totalSlots: Int = 3
        static let basePlayerHP: Int = 100
        static let basePlayerAtk: Int = 10
    }
    
    struct Reward {
        static let minBonusPercent: Double = 0.01
        static let maxBonusPercent: Double = 0.03
    }
    
    struct UI {
        static let slotFontSize: CGFloat = 50.0
        static let buttonFontSize: CGFloat = 20.0
        static let slotSpacing: CGFloat = 80.0
        
        static let spinAnimationDuration: TimeInterval = 0.1
        static let spinRepeatCount: Int = 5
        static let attackMoveDuration: TimeInterval = 0.2
    }
}
