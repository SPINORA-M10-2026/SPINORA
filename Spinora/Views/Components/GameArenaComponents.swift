//
//  ArenaLayout.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI

struct ArenaLayout: View {
    let data: BattleLayoutData

    var body: some View {
        ZStack {
            AssetSlot(
                "battle_background",
                fill: Color(red: 0.86, green: 0.75, blue: 0.48),
                cornerRadius: 0,
                showLabel: true
            )
            .frame(width: 832, height: 850)
            .position(x: 416, y: 715)

            HealthBarSlot(
                label: "enemy_hp_bar",
                value: "\(data.enemyHP)",
                current: data.enemyHP,
                max: data.enemyMaxHP,
                fillColor: GameColor.hpRed
            )
            .frame(width: 270, height: 30)
            .position(x: 445, y: 455)

            AssetSlot(
                "enemy_idle",
                fill: Color.purple.opacity(0.18),
                cornerRadius: 16
            )
            .frame(width: 175, height: 175)
            .position(x: 690, y: 525)

            AssetSlot(
                "enemy_shadow",
                fill: Color.black.opacity(0.35),
                cornerRadius: 20,
                showLabel: false
            )
            .frame(width: 120, height: 24)
            .position(x: 690, y: 627)

            AssetSlot(
                "player_idle",
                fill: Color.blue.opacity(0.18),
                cornerRadius: 16
            )
            .frame(width: 165, height: 205)
            .position(x: 112, y: 860)

            AssetSlot(
                "player_shadow",
                fill: Color.black.opacity(0.25),
                cornerRadius: 20,
                showLabel: false
            )
            .frame(width: 120, height: 24)
            .position(x: 112, y: 975)

            HealthBarSlot(
                label: "player_hp_bar",
                value: "\(data.playerHP)",
                current: data.playerHP,
                max: data.playerMaxHP,
                fillColor: GameColor.hpGreen
            )
            .frame(width: 205, height: 28)
            .position(x: 350, y: 820)

            AttackStatSlot(text: data.playerAttackText)
                .frame(width: 140, height: 34)
                .position(x: 325, y: 860)
        }
    }
}

struct HealthBarSlot: View {
    let label: String
    let value: String
    let current: Int
    let max: Int
    let fillColor: Color

    private var ratio: CGFloat {
        guard max > 0 else { return 0 }
        return Swift.max(0, Swift.min(1, CGFloat(current) / CGFloat(max)))
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                AssetSlot(
                    label,
                    fill: GameColor.wood,
                    cornerRadius: 7,
                    showLabel: false
                )

                RoundedRectangle(cornerRadius: 6)
                    .fill(fillColor)
                    .frame(width: Swift.max(10, (geo.size.width - 12) * ratio))
                    .padding(.leading, 7)
                    .padding(.vertical, 5)

                GamePixelText(value, size: 17)
                    .padding(.leading, 18)
            }
        }
    }
}

struct AttackStatSlot: View {
    let text: String

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

                GamePixelText(text, size: 17)
            }
        }
    }
}
