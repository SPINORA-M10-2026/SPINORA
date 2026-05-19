//
//  ArenaLayout.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI

struct ArenaLayout: View {
    let data: BattleLayoutData
    var playerState: PlayerAnimationState = .idle
    var enemyAppearance: EnemyAppearance? = nil

    @State private var enemyFloat: CGFloat = 0

    var body: some View {
        ZStack {
            // enemy HP bar
            HealthBarSlot(
                label: "enemy_hp_bar",
                value: "\(data.enemyHP)",
                current: data.enemyHP,
                max: data.enemyMaxHP,
                fillColor: GameColor.hpRed
            )
            .frame(width: 220, height: 40)
            .position(x: 460, y: 430)

            // enemy avatar
            Group {
                if let appearance = enemyAppearance {
                    EnemySpriteView(appearance: appearance)
                        .frame(width: 270, height: 270)
                } else {
                    AssetSlot(
                        "enemy_idle",
                        fill: Color.purple.opacity(0.18),
                        cornerRadius: 16
                    )
                    .frame(width: 270, height: 270)
                }
            }
            .position(x: 660, y: 480 + enemyFloat)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
                    enemyFloat = -12
                }
            }

            // player avatar
            PlayerSpriteView(state: playerState)
                .frame(width: 270)
                .position(x: 150, y: 820)

            // player HP bar
            HealthBarSlot(
                label: "player_hp_bar",
                value: "\(data.playerHP)",
                current: data.playerHP,
                max: data.playerMaxHP,
                fillColor: GameColor.hpGreen
            )
            .frame(width: 220, height: 40)
            .position(x: 360, y: 830)

            // player ATK bar
            AttackStatSlot(text: data.playerAttackText)
                .frame(width: 140, height: 40)
                .position(x: 290, y: 870)
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

