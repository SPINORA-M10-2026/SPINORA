import Foundation
import SwiftData

struct UpgradeRecordRepository {
    let modelContext: ModelContext

    func add(_ record: UpgradeRecordModel) throws {
        modelContext.insert(record)
        try modelContext.save()
    }

    func fetchAll() throws -> [UpgradeRecordModel] {
        let descriptor = FetchDescriptor<UpgradeRecordModel>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        return try modelContext.fetch(descriptor)
    }
}
