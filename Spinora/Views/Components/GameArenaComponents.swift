//
//  ArenaLayout.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI

struct ArenaLayout: View {
    var body: some View {
        ZStack {
            // Battle background slot
            AssetSlot(
                "battle_background",
                fill: Color(red: 0.86, green: 0.75, blue: 0.48),
                cornerRadius: 0,
                showLabel: true
            )
            .frame(width: 832, height: 850)
            .position(x: 416, y: 715)

            // Enemy HP
            HealthBarSlot(
                label: "enemy_hp_bar",
                value: "90",
                fillColor: GameColor.hpRed
            )
            .frame(width: 270, height: 30)
            .position(x: 445, y: 455)

            // Enemy asset slot
            AssetSlot(
                "enemy_idle",
                fill: Color.purple.opacity(0.18),
                cornerRadius: 16
            )
            .frame(width: 175, height: 175)
            .position(x: 690, y: 525)

            // Enemy shadow slot
            AssetSlot(
                "enemy_shadow",
                fill: Color.black.opacity(0.35),
                cornerRadius: 20,
                showLabel: false
            )
            .frame(width: 120, height: 24)
            .position(x: 690, y: 627)

            // Player asset slot
            AssetSlot(
                "player_idle",
                fill: Color.blue.opacity(0.18),
                cornerRadius: 16
            )
            .frame(width: 165, height: 205)
            .position(x: 112, y: 860)

            // Player HP
            HealthBarSlot(
                label: "player_hp_bar",
                value: "90",
                fillColor: GameColor.hpGreen
            )
            .frame(width: 205, height: 28)
            .position(x: 350, y: 820)

            // Player attack stat
            AttackStatSlot()
                .frame(width: 140, height: 34)
                .position(x: 325, y: 860)
        }
    }
}

struct HealthBarSlot: View {
    let label: String
    let value: String
    let fillColor: Color

    var body: some View {
        ZStack(alignment: .leading) {
            AssetSlot(
                label,
                fill: GameColor.wood,
                cornerRadius: 7,
                showLabel: false
            )

            RoundedRectangle(cornerRadius: 6)
                .fill(fillColor)
                .padding(.leading, 7)
                .padding(.trailing, 38)
                .padding(.vertical, 5)

            GamePixelText(value, size: 17)
                .padding(.leading, 18)
        }
    }
}

struct AttackStatSlot: View {
    var body: some View {
        ZStack {
            AssetSlot(
                "attack_stat_bar",
                fill: GameColor.wood,
                cornerRadius: 6,
                showLabel: false
            )

            HStack(spacing: 6) {
                Text("⚔️")
                    .font(.system(size: 19))

                GamePixelText("79.90", size: 17)
            }
        }
    }
}
