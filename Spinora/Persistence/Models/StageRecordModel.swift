import Foundation
import SwiftData

@Model
final class StageRecordModel {
    var runID: UUID
    var stage: Int
    var rewardCoins: Int
    var clearedAt: Date

    init(runID: UUID, stage: Int, rewardCoins: Int, clearedAt: Date = Date()) {
        self.runID = runID
        self.stage = stage
        self.rewardCoins = rewardCoins
        self.clearedAt = clearedAt
    }
}
