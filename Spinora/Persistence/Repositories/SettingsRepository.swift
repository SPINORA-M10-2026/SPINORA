import Foundation
import SwiftData

struct SettingsRepository {
    let modelContext: ModelContext

    func fetchSettings() throws -> GameSettingsModel {
        var descriptor = FetchDescriptor<GameSettingsModel>()
        descriptor.fetchLimit = 1

        if let settings = try modelContext.fetch(descriptor).first {
            return settings
        }

        let settings = GameSettingsModel()
        modelContext.insert(settings)
        try modelContext.save()
        return settings
    }

    func save() throws {
        try modelContext.save()
    }
}
