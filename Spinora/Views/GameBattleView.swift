//
//  GameBattleView.swift
//  challenge2_test
//

import SwiftUI

struct GameBattleView: View {
    let onPauseTap: () -> Void
    let onAttackTap: () -> Void
    let onInventoryTap: () -> Void
    let onWaveClearDemoTap: () -> Void

    var body: some View {
        GeometryReader { geo in
            ZStack {
                GameBackground()

                VStack(spacing: 0) {
                    TopHUD(onPauseTap: onPauseTap)

                    BattleArena()

                    Spacer(minLength: 0)

                    ReelPanel()

                    BottomActionBar(
                        onAttackTap: onAttackTap,
                        onInventoryTap: onInventoryTap,
                        onWaveClearDemoTap: onWaveClearDemoTap
                    )
                }
                .ignoresSafeArea(edges: .bottom)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}