//
//  CombatSummary.swift
//  Spinora
//

import Foundation

struct CombatSummary {
    let playerDamage: Int
    let monsterDamage: Int
    let comboEffect: ComboEffect
    let playerElements: [Element]
    let isPlayerDead: Bool
    let isMonsterDead: Bool
    let battleMessage: String
}
