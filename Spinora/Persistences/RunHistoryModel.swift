//
//  RunHistoryModel.swift
//  Spinora
//

import Foundation
import SwiftData

@Model
final class RunHistoryModel {
    var id: UUID
    var runID: UUID
    var finalWave: Int
    var finalPlayerHP: Int
    var outcome: String
    var playedAt: Date

    init(
        id: UUID = UUID(),
        runID: UUID = UUID(),
        finalWave: Int,
        finalPlayerHP: Int,
        outcome: String,
        playedAt: Date = Date()
    ) {
        self.id = id
        self.runID = runID
        self.finalWave = finalWave
        self.finalPlayerHP = finalPlayerHP
        self.outcome = outcome
        self.playedAt = playedAt
    }
}
