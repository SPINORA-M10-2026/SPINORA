import Foundation
import SwiftData

struct ReelStatsRepository {
    let modelContext: ModelContext

    func add(_ stats: ReelStatsModel) throws {
        modelContext.insert(stats)
        try modelContext.save()
    }

    func fetchAll() throws -> [ReelStatsModel] {
        let descriptor = FetchDescriptor<ReelStatsModel>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        return try modelContext.fetch(descriptor)
    }
}
