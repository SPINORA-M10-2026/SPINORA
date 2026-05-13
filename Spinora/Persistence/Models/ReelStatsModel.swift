import Foundation
import SwiftData

@Model
final class ReelStatsModel {
    var runID: UUID
    var elementRawValue: String
    var rollCount: Int
    var createdAt: Date

    init(runID: UUID, elementRawValue: String, rollCount: Int, createdAt: Date = Date()) {
        self.runID = runID
        self.elementRawValue = elementRawValue
        self.rollCount = rollCount
        self.createdAt = createdAt
    }
}
