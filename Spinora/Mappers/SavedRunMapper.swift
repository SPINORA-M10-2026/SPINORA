//
//  SavedRunMapper.swift
//  Spinora
//

import Foundation

struct SavedRunMapper {

    // MARK: - Simple Character Mapping

    static func toModel(wave: Int, player: Character) -> SavedRunModel {
        SavedRunModel(
            currentWave: wave,
            playerHP: player.hp,
            playerMaxHP: player.maxHp,
            playerBaseAttack: player.baseAttack
        )
    }

    static func toGameState(from model: SavedRunModel) -> (wave: Int, player: Character) {
        let player = Character(
            hp: model.playerHP,
            maxHp: model.playerMaxHP,
            baseAttack: model.playerBaseAttack,
            element: nil
        )

        return (
            wave: model.currentWave,
            player: player
        )
    }

    // MARK: - Full Run Mapping

    static func toModel(
        currentWave: Int,
        player: Character,
        enemy: Character,
        accumulatedBonusHP: Int,
        accumulatedBonusAttack: Int,
        currentReelSymbols: [String],
        rolledThisTurn: [Bool],
        isPlayerDead: Bool = false,
        canRetryWave: Bool = false
    ) -> SavedRunModel {
        SavedRunModel(
            currentWave: currentWave,
            playerHP: player.hp,
            playerMaxHP: player.maxHp,
            playerBaseAttack: player.baseAttack,
            enemyHP: enemy.hp,
            enemyMaxHP: enemy.maxHp,
            accumulatedBonusHP: accumulatedBonusHP,
            accumulatedBonusAttack: accumulatedBonusAttack,
            currentReelSymbols: currentReelSymbols,
            rolledThisTurn: rolledThisTurn,
            isPlayerDead: isPlayerDead,
            canRetryWave: canRetryWave
        )
    }

    static func toFullGameState(
        from model: SavedRunModel
    ) -> (
        wave: Int,
        player: Character,
        enemy: Character,
        accumulatedBonusHP: Int,
        accumulatedBonusAttack: Int,
        currentReelSymbols: [String],
        rolledThisTurn: [Bool],
        isPlayerDead: Bool,
        canRetryWave: Bool
    ) {
        let player = Character(
            hp: model.playerHP,
            maxHp: model.playerMaxHP,
            baseAttack: model.playerBaseAttack,
            element: nil
        )

        let enemy = Character(
            hp: model.enemyHP,
            maxHp: model.enemyMaxHP,
            baseAttack: 0,
            element: nil
        )

        return (
            wave: model.currentWave,
            player: player,
            enemy: enemy,
            accumulatedBonusHP: model.accumulatedBonusHP,
            accumulatedBonusAttack: model.accumulatedBonusAttack,
            currentReelSymbols: model.currentReelSymbols,
            rolledThisTurn: model.rolledThisTurn,
            isPlayerDead: model.isPlayerDead,
            canRetryWave: model.canRetryWave
        )
    }
}
