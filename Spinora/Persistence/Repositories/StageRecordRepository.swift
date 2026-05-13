import Foundation
import SwiftData

struct StageRecordRepository {
    let modelContext: ModelContext

    func add(_ record: StageRecordModel) throws {
        modelContext.insert(record)
        try modelContext.save()
    }

    func fetchAll() throws -> [StageRecordModel] {
        let descriptor = FetchDescriptor<StageRecordModel>(sortBy: [SortDescriptor(\.clearedAt, order: .reverse)])
        return try modelContext.fetch(descriptor)
    }
}
