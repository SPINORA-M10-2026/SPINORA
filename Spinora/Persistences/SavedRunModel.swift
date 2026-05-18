//
//  SavedRunModel.swift
//  Spinora
//

import Foundation
import SwiftData

@Model
final class SavedRunModel {
    var runID: UUID
    var currentWave: Int
    var playerHP: Int
    var playerMaxHP: Int
    var playerBaseAttack: Int
    var savedAt: Date

    init(
        runID: UUID = UUID(),
        currentWave: Int,
        playerHP: Int,
        playerMaxHP: Int,
        playerBaseAttack: Int,
        savedAt: Date = Date()
    ) {
        self.runID = runID
        self.currentWave = currentWave
        self.playerHP = playerHP
        self.playerMaxHP = playerMaxHP
        self.playerBaseAttack = playerBaseAttack
        self.savedAt = savedAt
    }
}
