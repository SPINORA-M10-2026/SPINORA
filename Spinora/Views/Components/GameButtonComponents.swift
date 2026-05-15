//
//  BottomActionBarView.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI

struct BottomButtonLayout: View {
    var body: some View {
        ZStack {
            Button {
                print("Attack tapped")
            } label: {
                AttackButtonSlot()
            }
            .buttonStyle(.plain)
            .frame(width: 245, height: 105)
            .position(x: 685, y: 1035)
        }
    }
}

struct AttackButtonSlot: View {
    var body: some View {
        ZStack {
            AssetSlot(
                "attack_button",
                fill: GameColor.buttonYellow,
                cornerRadius: 16,
                showLabel: false
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(GameColor.wood, lineWidth: 5)
            )

            VStack(spacing: -4) {
                GamePixelText("⚔️", size: 48)

                GamePixelText("ATTACK", size: 27)
            }
        }
    }
}
