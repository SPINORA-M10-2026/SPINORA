import Foundation

enum RunHistoryMapper {
    static func makeModel(runID: UUID = UUID(), finalStage: Int, coinsEarned: Int, didWin: Bool) -> RunHistoryModel {
        RunHistoryModel(
            runID: runID,
            finalStage: finalStage,
            coinsEarned: coinsEarned,
            result: didWin ? "win" : "defeat"
        )
    }
}
