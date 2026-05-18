//
//  RunUpgradeModel.swift
//  Spinora
//
//  Created by Stanley Young on 18/05/26.
//

import Foundation
import SwiftData

@Model
final class RunUpgradeModel {
    @Attribute(.unique) var id: String

    var upgradeKey: String
    var upgradeName: String

    var level: Int
    var bonusHP: Int
    var bonusAttack: Int

    var acquiredAt: Date
    var updatedAt: Date

    init(
        id: String = UUID().uuidString,
        upgradeKey: String,
        upgradeName: String,
        level: Int = 1,
        bonusHP: Int = 0,
        bonusAttack: Int = 0,
        acquiredAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id

        self.upgradeKey = upgradeKey
        self.upgradeName = upgradeName

        self.level = level
        self.bonusHP = bonusHP
        self.bonusAttack = bonusAttack

        self.acquiredAt = acquiredAt
        self.updatedAt = updatedAt
    }
}
