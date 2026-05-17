//
//  BattleLayoutData.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import Foundation

struct BattleLayoutData {
    var waveText: String

    var playerHP: Int
    var playerMaxHP: Int
    var playerAttackText: String

    var enemyHP: Int
    var enemyMaxHP: Int

    var rerollText: String
    var reelColumns: [[String]]
    var reelRolledThisTurn: [Bool]
    var lastRolledIndex: Int?

    var canAttack: Bool

    static let preview = BattleLayoutData(
        waveText: "001",
        playerHP: 90,
        playerMaxHP: 100,
        playerAttackText: "79.90",
        enemyHP: 90,
        enemyMaxHP: 100,
        rerollText: "↻ 3/3",
        reelColumns: [
            ["💧", "🔥", "🔥"],
            ["🔥", "💧", "🪨"],
            ["🪨", "🪨", "💧"]
        ],
        reelRolledThisTurn: [false, false, false],
        lastRolledIndex: nil,
        canAttack: true
    )
}
