//
//  GameSaveData.swift
//  SPINORA
//
//  Created by oky faishal on 12/05/26.
//

import Foundation
import SwiftData

@Model
class GameSaveData {
    var currentStage: Int
    var playerHP: Int
    var playerMaxHP: Int
    var playerATK: Int
    
    init(currentStage: Int, playerHP: Int, playerMaxHP: Int, playerATK: Int) {
        self.currentStage = currentStage
        self.playerHP = playerHP
        self.playerMaxHP = playerMaxHP
        self.playerATK = playerATK
    }
}
