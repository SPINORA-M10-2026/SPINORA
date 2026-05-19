//
//  SpinoraTests.swift
//  SpinoraTests
//

import XCTest
@testable import Spinora

final class SpinoraTests: XCTestCase {

    let combat = CombatManager()

    // Jalankan semua scenario sekaligus — lihat output di console Xcode
    func testCombatSimulation() {
        simulatePlayerAttack()
        simulateEnemyCounterattack()
        simulatePlayerWin()
        simulatePlayerLose()
        simulateDoubleCombo()
        simulateTripleCombo()
    }

    // MARK: - 1. Player Attack & Enemy Defend

    private func simulatePlayerAttack() {
        print("\n============================")
        print("1. PLAYER ATTACK & ENEMY DEFEND")
        print("============================")

        let player  = Character(hp: 100, maxHp: 100, baseAttack: 20, element: nil)
        let monster = Character(hp: 100, maxHp: 100, baseAttack: 10, element: .fire)
        // Water beats Fire → 2x multiplier
        let reel = ReelState(symbols: [.water, .earth, .earth], rolledThisTurn: [true, true, true])

        let (_, updatedMonster, summary) = combat.resolveAttack(player: player, monster: monster, reelState: reel)

        print("Reel symbols  : \(reel.symbols.map(\.name))")
        print("Monster element: \(monster.element!.name)")
        print("Player damage  : \(summary.playerDamage)")
        print("Monster HP after: \(updatedMonster.hp)/\(updatedMonster.maxHp)")
        print("Message: \(summary.battleMessage)")
    }

    // MARK: - 2. Enemy Counterattack & Player Defend

    private func simulateEnemyCounterattack() {
        print("\n============================")
        print("2. ENEMY COUNTERATTACK & PLAYER DEFEND")
        print("============================")

        let player  = Character(hp: 100, maxHp: 100, baseAttack: 5, element: nil)
        // Monster punya ATK tinggi, HP cukup untuk tetap hidup setelah serangan player
        let monster = Character(hp: 100, maxHp: 100, baseAttack: 25, element: .fire)
        // Fire vs Fire → 1x (neutral), damage player kecil → monster tidak mati → balas serang
        let reel = ReelState(symbols: [.fire, .fire, .fire], rolledThisTurn: [true, true, true])

        let (updatedPlayer, updatedMonster, summary) = combat.resolveAttack(player: player, monster: monster, reelState: reel)

        print("Reel symbols   : \(reel.symbols.map(\.name))")
        print("Player damage  : \(summary.playerDamage)")
        print("Monster HP after: \(updatedMonster.hp)/\(updatedMonster.maxHp)")
        print("Monster ATK    : \(monster.baseAttack)")
        print("Monster damage : \(summary.monsterDamage)")
        print("Player HP after: \(updatedPlayer.hp)/\(updatedPlayer.maxHp)")
        print("Message: \(summary.battleMessage)")
    }

    // MARK: - 3. Player Win (Monster HP → 0)

    private func simulatePlayerWin() {
        print("\n============================")
        print("3. PLAYER WIN")
        print("============================")

        let player  = Character(hp: 100, maxHp: 100, baseAttack: 50, element: nil)
        let monster = Character(hp: 30, maxHp: 100, baseAttack: 10, element: .fire)
        // Water beats Fire → monster langsung mati
        let reel = ReelState(symbols: [.water, .water, .water], rolledThisTurn: [true, true, true])

        let (_, updatedMonster, summary) = combat.resolveAttack(player: player, monster: monster, reelState: reel)

        print("Monster HP before: \(monster.hp)")
        print("Player damage    : \(summary.playerDamage)")
        print("Monster HP after : \(updatedMonster.hp)")
        print("isMonsterDead    : \(summary.isMonsterDead)")
        print("Monster damage   : \(summary.monsterDamage) (harusnya 0 karena monster mati duluan)")
        print("Message: \(summary.battleMessage)")
    }

    // MARK: - 4. Player Lose (Player HP → 0)

    private func simulatePlayerLose() {
        print("\n============================")
        print("4. PLAYER LOSE")
        print("============================")

        let player  = Character(hp: 5, maxHp: 100, baseAttack: 1, element: nil)
        let monster = Character(hp: 999, maxHp: 999, baseAttack: 50, element: .fire)
        // Earth vs Fire → 0.5x, damage kecil → monster tidak mati → balas serang → player mati
        let reel = ReelState(symbols: [.earth, .earth, .earth], rolledThisTurn: [true, true, true])

        let (updatedPlayer, updatedMonster, summary) = combat.resolveAttack(player: player, monster: monster, reelState: reel)

        print("Player HP before : \(player.hp)")
        print("Player damage    : \(summary.playerDamage)")
        print("Monster HP after : \(updatedMonster.hp)")
        print("Monster damage   : \(summary.monsterDamage)")
        print("Player HP after  : \(updatedPlayer.hp)")
        print("isPlayerDead     : \(summary.isPlayerDead)")
        print("Message: \(summary.battleMessage)")
    }

    // MARK: - 5. Double Combo (2 elemen kuat)

    private func simulateDoubleCombo() {
        print("\n============================")
        print("5. DOUBLE COMBO (2 Super Effective)")
        print("============================")

        let player  = Character(hp: 100, maxHp: 100, baseAttack: 20, element: nil)
        let monster = Character(hp: 999, maxHp: 999, baseAttack: 5, element: .fire)
        // 2x Water beats Fire → Double Combo (x2 multiplier)
        let reel = ReelState(symbols: [.water, .water, .earth], rolledThisTurn: [true, true, true])

        let (_, _, summary) = combat.resolveAttack(player: player, monster: monster, reelState: reel)

        print("Reel    : \(reel.symbols.map(\.name))")
        print("Combo   : \(summary.comboEffect)")
        print("Damage  : \(summary.playerDamage)")
        print("Message : \(summary.battleMessage)")
    }

    // MARK: - 6. Triple Combo (3 elemen kuat)

    private func simulateTripleCombo() {
        print("\n============================")
        print("6. TRIPLE COMBO (3 Super Effective)")
        print("============================")

        let player  = Character(hp: 100, maxHp: 100, baseAttack: 20, element: nil)
        let monster = Character(hp: 999, maxHp: 999, baseAttack: 5, element: .fire)
        // 3x Water beats Fire → Triple Combo (x4 multiplier)
        let reel = ReelState(symbols: [.water, .water, .water], rolledThisTurn: [true, true, true])

        let (_, _, summary) = combat.resolveAttack(player: player, monster: monster, reelState: reel)

        print("Reel    : \(reel.symbols.map(\.name))")
        print("Combo   : \(summary.comboEffect)")
        print("Damage  : \(summary.playerDamage)")
        print("Message : \(summary.battleMessage)")
        print("\n============================\n")
    }

    // MARK: - 7. Attack Button Press — Weakness Correlation Report

    func testAttackButtonPress() {
        // Simulasi state saat tombol Attack ditekan
        let player  = Character(hp: 100, maxHp: 100, baseAttack: 20, element: nil)
        let monster = Character(hp: 200, maxHp: 200, baseAttack: 15, element: .fire)

        // Ganti symbols di sini untuk simulasi reel yang berbeda
        let reelSymbols: [Element] = [.water, .fire, .earth]
        let reel = ReelState(symbols: reelSymbols, rolledThisTurn: [true, true, true])

        let monsterElement = monster.element!

        // Elemen apa yang kuat terhadap monster ini
        let effectiveElements = Element.allCases.filter { $0.beats(monsterElement) }

        print("\n╔══════════════════════════════════════╗")
        print("║        ATTACK BUTTON PRESSED         ║")
        print("╚══════════════════════════════════════╝")

        print("\n── Monster Info ──────────────────────")
        print("  Element  : \(monsterElement.name)")
        print("  HP       : \(monster.hp)/\(monster.maxHp)")
        print("  ATK      : \(monster.baseAttack)")
        print("  Weakness : \(effectiveElements.map(\.name).joined(separator: ", "))")

        print("\n── Reel Result ───────────────────────")
        for (index, symbol) in reel.symbols.enumerated() {
            let multiplier = symbol.damageMultiplier(against: monsterElement)
            let label: String
            switch multiplier {
            case 2.0: label = "SUPER EFFECTIVE ×2.0 ✓"
            case 0.5: label = "Not Effective   ×0.5 ✗"
            default:  label = "Neutral         ×1.0 –"
            }
            print("  Slot \(index + 1): \(symbol.name.padding(toLength: 6, withPad: " ", startingAt: 0)) → \(label)")
        }

        let hitCount = reel.symbols.filter { $0.damageMultiplier(against: monsterElement) == 2.0 }.count
        let isCorrelated = hitCount > 0

        print("\n── Weakness Correlation ──────────────")
        print("  Slots kena weakness : \(hitCount)/\(reel.symbols.count)")
        print("  Correlated          : \(isCorrelated ? "YES ✓" : "NO ✗")")

        let (_, updatedMonster, summary) = combat.resolveAttack(player: player, monster: monster, reelState: reel)

        print("\n── Combat Result ─────────────────────")
        print("  Combo         : \(summary.comboEffect == .none ? "Tidak ada" : summary.comboEffect.displayName)")
        print("  Player Damage : \(summary.playerDamage)")
        print("  Monster HP    : \(monster.hp) → \(updatedMonster.hp)/\(updatedMonster.maxHp)")
        print("  Monster Balas : \(summary.monsterDamage > 0 ? "\(summary.monsterDamage) DMG" : "Tidak (sudah mati)")")
        print("  Message       : \(summary.battleMessage)")
        print("\n══════════════════════════════════════\n")

        // Assertions — pastikan logika benar
        XCTAssertGreaterThan(summary.playerDamage, 0, "Damage harus lebih dari 0")
        let actualHitCount = summary.playerElements.filter {
            $0.damageMultiplier(against: monsterElement) == 2.0
        }.count
        XCTAssertEqual(actualHitCount, hitCount, "Jumlah slot kena weakness harus konsisten")
    }
}
