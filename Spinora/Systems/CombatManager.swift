//
//  CombatManager.swift
//  Spinora
//

import Foundation

final class CombatManager {

    func resolveAttack(
        player: Character,
        monster: Character,
        reelState: ReelState
    ) -> (updatedPlayer: Character, updatedMonster: Character, summary: CombatSummary) {
        let playerElements = reelState.symbols
        let enemyElement = monster.element ?? .fire

        let playerDamage = DamageCalculator.calculateDamage(
            playerElements: playerElements,
            enemyElement: enemyElement,
            baseAttack: player.baseAttack
        )

        var updatedMonster = monster
        updatedMonster.takeDamage(playerDamage)

        let combo = detectCombo(playerElements: playerElements, enemyElement: enemyElement)

        var updatedPlayer = player
        var monsterDamage = 0
        if !updatedMonster.isDead {
            monsterDamage = monster.baseAttack
            updatedPlayer.takeDamage(monsterDamage)
        }

        let message = buildMessage(
            playerDamage: playerDamage,
            monsterDamage: monsterDamage,
            combo: combo,
            isMonsterDead: updatedMonster.isDead,
            isPlayerDead: updatedPlayer.isDead
        )

        let summary = CombatSummary(
            playerDamage: playerDamage,
            monsterDamage: monsterDamage,
            comboEffect: combo,
            playerElements: playerElements,
            isPlayerDead: updatedPlayer.isDead,
            isMonsterDead: updatedMonster.isDead,
            battleMessage: message
        )

        return (updatedPlayer, updatedMonster, summary)
    }

    // MARK: - Private

    private func detectCombo(playerElements: [Element], enemyElement: Element) -> ComboEffect {
        let strongCount = playerElements.filter {
            $0.damageMultiplier(against: enemyElement) == 2.0
        }.count

        switch strongCount {
        case 3:  return .triple
        case 2:  return .double
        default: return .none
        }
    }

    private func buildMessage(
        playerDamage: Int,
        monsterDamage: Int,
        combo: ComboEffect,
        isMonsterDead: Bool,
        isPlayerDead: Bool
    ) -> String {
        if isPlayerDead  { return "YOU DIED!" }
        if isMonsterDead { return "ENEMY DEFEATED!" }
        if combo != .none { return "\(combo.displayName) \(playerDamage) DMG!" }
        return "Dealt \(playerDamage) DMG. Enemy hit back \(monsterDamage)."
    }
}
