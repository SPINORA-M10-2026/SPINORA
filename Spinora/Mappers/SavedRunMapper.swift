//
//  SavedRunMapper.swift
//  Spinora
//

import Foundation

struct SavedRunMapper {

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
        return (wave: model.currentWave, player: player)
    }
}
