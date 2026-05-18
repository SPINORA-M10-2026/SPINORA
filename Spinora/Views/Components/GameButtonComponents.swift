//
//  BottomActionBarView.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI

struct BottomButtonLayout: View {
    let canAttack: Bool
    let onAttackTap: () -> Void

    var body: some View {
        ZStack {
            Button(action: onAttackTap) {
                AttackButtonSlot(isEnabled: canAttack)
            }
            .buttonStyle(.plain)
            .disabled(!canAttack)
            .frame(width: 245, height: 105)
            .position(x: 685, y: 1035)
        }
    }
}

struct AttackButtonSlot: View {
    let isEnabled: Bool

    var body: some View {
        ZStack {
            AssetSlot(
                "attack_button",
                fill: isEnabled ? GameColor.buttonYellow : Color.gray,
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
        .opacity(isEnabled ? 1.0 : 0.55)
    }
}
