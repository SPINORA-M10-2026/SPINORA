//
//  PlayerProfileModel.swift
//  Spinora
//
//  Created by Stanley Young on 18/05/26.
//

import Foundation
import SwiftData

@Model
final class PlayerProfileModel {
    @Attribute(.unique) var id: String

    var playerName: String

    var highestWave: Int
    var totalRuns: Int
    var totalDeaths: Int
    var totalEnemiesDefeated: Int

    var baseMaxHP: Int
    var baseAttack: Int

    var createdAt: Date
    var updatedAt: Date

    init(
        id: String = "main_player",
        playerName: String = "Player",
        highestWave: Int = 1,
        totalRuns: Int = 0,
        totalDeaths: Int = 0,
        totalEnemiesDefeated: Int = 0,
        baseMaxHP: Int = 100,
        baseAttack: Int = 20,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.playerName = playerName
        self.highestWave = highestWave
        self.totalRuns = totalRuns
        self.totalDeaths = totalDeaths
        self.totalEnemiesDefeated = totalEnemiesDefeated
        self.baseMaxHP = baseMaxHP
        self.baseAttack = baseAttack
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
