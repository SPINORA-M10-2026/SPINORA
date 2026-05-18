//
//  SavedRunRepository.swift
//  Spinora
//

import Foundation
import SwiftData

final class SavedRunRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(_ model: SavedRunModel) throws {
        let existing = try context.fetch(FetchDescriptor<SavedRunModel>())
        existing.forEach { context.delete($0) }
        context.insert(model)
        try context.save()
    }

    func load() throws -> SavedRunModel? {
        try context.fetch(FetchDescriptor<SavedRunModel>()).first
    }

    func delete() throws {
        let existing = try context.fetch(FetchDescriptor<SavedRunModel>())
        existing.forEach { context.delete($0) }
        try context.save()
    }
}
