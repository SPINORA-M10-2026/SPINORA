//
//  RunHistoryMapper.swift
//  Spinora
//

import Foundation

enum RunOutcome: String {
    case victory = "victory"
    case defeat  = "defeat"
}

struct RunHistoryMapper {

    static func toModel(wave: Int, player: Character, outcome: RunOutcome) -> RunHistoryModel {
        RunHistoryModel(
            finalWave: wave,
            finalPlayerHP: player.hp,
            outcome: outcome.rawValue
        )
    }
}
