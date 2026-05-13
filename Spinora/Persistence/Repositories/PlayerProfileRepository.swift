import Foundation
import SwiftData

struct PlayerProfileRepository {
    let modelContext: ModelContext

    func fetchProfile() throws -> PlayerProfileModel {
        var descriptor = FetchDescriptor<PlayerProfileModel>()
        descriptor.fetchLimit = 1

        if let profile = try modelContext.fetch(descriptor).first {
            return profile
        }

        let profile = PlayerProfileModel()
        modelContext.insert(profile)
        try modelContext.save()
        return profile
    }

    func save() throws {
        try modelContext.save()
    }
}
