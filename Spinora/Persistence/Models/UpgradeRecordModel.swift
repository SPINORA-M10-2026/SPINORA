import Foundation
import SwiftData

@Model
final class UpgradeRecordModel {
    var runID: UUID
    var upgradeKindRawValue: String
    var value: Int
    var stage: Int
    var createdAt: Date

    init(runID: UUID, upgradeKindRawValue: String, value: Int, stage: Int, createdAt: Date = Date()) {
        self.runID = runID
        self.upgradeKindRawValue = upgradeKindRawValue
        self.value = value
        self.stage = stage
        self.createdAt = createdAt
    }
}
