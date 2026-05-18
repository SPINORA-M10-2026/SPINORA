//
//  RunUpgradeRepository.swift
//  Spinora
//
//  Created by Stanley Young on 18/05/26.
//

import Foundation
import SwiftData

@MainActor
final class RunUpgradeRepository {
    private let context: ModelContext
    private let savedRunRepository: SavedRunRepository

    init(context: ModelContext) {
        self.context = context
        self.savedRunRepository = SavedRunRepository(context: context)
    }

    func fetchAll() throws -> [RunUpgradeModel] {
        let descriptor = FetchDescriptor<RunUpgradeModel>(
            sortBy: [
                SortDescriptor(\.acquiredAt, order: .forward)
            ]
        )

        return try context.fetch(descriptor)
    }

    func addRunUpgrade(
        upgradeKey: String,
        upgradeName: String,
        bonusHP: Int = 0,
        bonusAttack: Int = 0
    ) throws {
        let run = try savedRunRepository.fetchOrCreateActiveRun()

        let descriptor = FetchDescriptor<RunUpgradeModel>(
            predicate: #Predicate { upgrade in
                upgrade.upgradeKey == upgradeKey
            }
        )

        if let existingUpgrade = try context.fetch(descriptor).first {
            existingUpgrade.level += 1
            existingUpgrade.bonusHP += bonusHP
            existingUpgrade.bonusAttack += bonusAttack
            existingUpgrade.updatedAt = Date()
        } else {
            let newUpgrade = RunUpgradeModel(
                upgradeKey: upgradeKey,
                upgradeName: upgradeName,
                level: 1,
                bonusHP: bonusHP,
                bonusAttack: bonusAttack
            )

            context.insert(newUpgrade)
        }

        run.accumulatedBonusHP += bonusHP
        run.accumulatedBonusAttack += bonusAttack

        run.playerMaxHP += bonusHP
        run.playerHP += bonusHP
        run.playerBaseAttack += bonusAttack

        run.savedAt = Date()

        try context.save()
    }

    func deleteAll() throws {
        let upgrades = try fetchAll()

        for upgrade in upgrades {
            context.delete(upgrade)
        }

        try context.save()
    }
}
