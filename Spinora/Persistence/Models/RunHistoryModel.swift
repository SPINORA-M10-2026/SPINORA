import Foundation
import SwiftData

@Model
final class RunHistoryModel {
    @Attribute(.unique) var runID: UUID
    var finalStage: Int
    var coinsEarned: Int
    var result: String
    var createdAt: Date

    init(runID: UUID = UUID(), finalStage: Int, coinsEarned: Int, result: String, createdAt: Date = Date()) {
        self.runID = runID
        self.finalStage = finalStage
        self.coinsEarned = coinsEarned
        self.result = result
        self.createdAt = createdAt
    }
}
