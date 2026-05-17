//
//  RunHistoryRepository.swift
//  Spinora
//

import Foundation
import SwiftData

final class RunHistoryRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func append(_ model: RunHistoryModel) throws {
        context.insert(model)
        try context.save()
    }

    func fetchAll() throws -> [RunHistoryModel] {
        let descriptor = FetchDescriptor<RunHistoryModel>(
            sortBy: [SortDescriptor(\.playedAt, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }
}
