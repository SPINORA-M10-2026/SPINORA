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
                Image("button_attack_default")
                    .resizable()
                    .frame(width: 220, height: 160)
                .opacity(canAttack ? 1.0 : 0.55)
//                AttackButtonSlot(isEnabled: canAttack)
            }
            .buttonStyle(.plain)
            .disabled(!canAttack)
            .position(x: 670, y: 980)
        }
    }
}

//struct AttackButtonSlot: View {
//    let isEnabled: Bool
//
//    var body: some View {
//        Image("button_attack_default")
//        .opacity(isEnabled ? 1.0 : 0.55)
//    }
//}
