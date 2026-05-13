import Foundation
import SwiftData

struct SavedRunRepository {
    let modelContext: ModelContext

    func save(_ run: SavedRunModel) throws {
        modelContext.insert(run)
        try modelContext.save()
    }

    func fetchActiveRun() throws -> SavedRunModel? {
        var descriptor = FetchDescriptor<SavedRunModel>(sortBy: [SortDescriptor(\.updatedAt, order: .reverse)])
        descriptor.fetchLimit = 1
        return try modelContext.fetch(descriptor).first
    }

    func delete(_ run: SavedRunModel) throws {
        modelContext.delete(run)
        try modelContext.save()
    }
}
