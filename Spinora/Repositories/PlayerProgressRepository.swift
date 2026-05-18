//
//  PlayerProgressRepository.swift
//  Spinora
//
//  Created by Stanley Young on 18/05/26.
//

import Foundation
import SwiftData

@MainActor
final class PlayerProgressRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchOrCreateProfile() throws -> PlayerProfileModel {
        let descriptor = FetchDescriptor<PlayerProfileModel>(
            predicate: #Predicate { profile in
                profile.id == "main_player"
            }
        )

        if let existingProfile = try context.fetch(descriptor).first {
            return existingProfile
        }

        let profile = PlayerProfileModel()
        context.insert(profile)
        try context.save()

        return profile
    }

    func updateHighestWave(_ wave: Int) throws {
        let profile = try fetchOrCreateProfile()

        if wave > profile.highestWave {
            profile.highestWave = wave
        }

        profile.updatedAt = Date()
        try context.save()
    }

    func recordNewRun() throws {
        let profile = try fetchOrCreateProfile()
        profile.totalRuns += 1
        profile.updatedAt = Date()
        try context.save()
    }

    func recordDeath() throws {
        let profile = try fetchOrCreateProfile()
        profile.totalDeaths += 1
        profile.updatedAt = Date()
        try context.save()
    }

    func recordEnemyDefeated() throws {
        let profile = try fetchOrCreateProfile()
        profile.totalEnemiesDefeated += 1
        profile.updatedAt = Date()
        try context.save()
    }
}
