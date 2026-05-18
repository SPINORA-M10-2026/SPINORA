//
//  RunHistoryRepository.swift
//  Spinora
//

import Foundation
import SwiftData

@MainActor
final class RunHistoryRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func append(_ model: RunHistoryModel) throws {
        context.insert(model)
        try context.save()
    }

    func appendFromSavedRun(
        _ run: SavedRunModel,
        outcome: RunOutcome
    ) throws {
        let history = RunHistoryModel(
            runID: run.runID,
            finalWave: run.currentWave,
            finalPlayerHP: run.playerHP,
            outcome: outcome.rawValue
        )

        context.insert(history)
        try context.save()
    }

    func fetchAll() throws -> [RunHistoryModel] {
        let descriptor = FetchDescriptor<RunHistoryModel>(
            sortBy: [
                SortDescriptor(\.playedAt, order: .reverse)
            ]
        )

        return try context.fetch(descriptor)
    }
}
