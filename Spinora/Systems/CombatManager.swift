import Foundation

final class CombatManager {
    func resolveAttack(
        playerElement: Element,
        monster: Monster,
        playerDamage: Int,
        playerHP: Int
    ) -> (monster: Monster, playerHP: Int, summary: CombatSummary) {
        var updatedMonster = monster
        let damage = calculateDamage(playerElement: playerElement, enemyElement: monster.element, baseDamage: playerDamage)
        updatedMonster.currentHP = max(0, updatedMonster.currentHP - damage)

        let didDefeatMonster = updatedMonster.currentHP == 0
        let counterDamage = didDefeatMonster ? 0 : monster.attack
        let updatedPlayerHP = max(0, playerHP - counterDamage)

        let summary = CombatSummary(
            playerElement: playerElement,
            monsterElement: monster.element,
            playerDamage: damage,
            monsterDamage: counterDamage,
            comboEffect: nil,
            didDefeatMonster: didDefeatMonster,
            didPlayerDie: updatedPlayerHP == 0,
            message: didDefeatMonster ? "Monster defeated" : "Monster counterattacked"
        )

        return (updatedMonster, updatedPlayerHP, summary)
    }

    func calculateDamage(playerElement: Element, enemyElement: Element, baseDamage: Int) -> Int {
        isWeakness(playerElement: playerElement, enemyElement: enemyElement) ? baseDamage * 2 : baseDamage
    }

    private func isWeakness(playerElement: Element, enemyElement: Element) -> Bool {
        switch (playerElement, enemyElement) {
        case (.water, .fire), (.earth, .water), (.fire, .earth):
            return true
        default:
            return false
        }
    }
}
