import Foundation
import SwiftData

struct RunHistoryRepository {
    let modelContext: ModelContext

    func add(_ history: RunHistoryModel) throws {
        modelContext.insert(history)
        try modelContext.save()
    }

    func fetchRecent(limit: Int = 20) throws -> [RunHistoryModel] {
        var descriptor = FetchDescriptor<RunHistoryModel>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        descriptor.fetchLimit = limit
        return try modelContext.fetch(descriptor)
    }
}
