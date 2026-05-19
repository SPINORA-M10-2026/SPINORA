//
//  RunHistoryMapper.swift
//  Spinora
//

import Foundation

enum RunOutcome: String {
    case victory = "victory"
    case defeat = "defeat"
    case rerun = "rerun"
}

struct RunHistoryMapper {

    static func toModel(
        wave: Int,
        player: Character,
        outcome: RunOutcome
    ) -> RunHistoryModel {
        RunHistoryModel(
            finalWave: wave,
            finalPlayerHP: player.hp,
            outcome: outcome.rawValue
        )
    }

    static func toModel(
        savedRun: SavedRunModel,
        outcome: RunOutcome
    ) -> RunHistoryModel {
        RunHistoryModel(
            runID: savedRun.runID,
            finalWave: savedRun.currentWave,
            finalPlayerHP: savedRun.playerHP,
            outcome: outcome.rawValue
        )
    }
}
