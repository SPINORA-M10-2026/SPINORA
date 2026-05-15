//
//  RibbonBanner.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//


//
//  GameOverlayComponents.swift
//  Spinora
//

import SwiftUI

struct RibbonBanner: View {
    let text: String

    var body: some View {
        ZStack {
            AssetSlot(
                "wave_clear_banner",
                fill: GameColor.buttonYellow,
                cornerRadius: 12,
                showLabel: false
            )
            .frame(width: 620, height: 110)

            GamePixelText(text, size: 38)
                .foregroundStyle(.white)
        }
    }
}

struct RewardCardView: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 14) {
                AssetSlot(
                    "reward_icon",
                    fill: Color.white.opacity(0.14),
                    cornerRadius: 14,
                    showLabel: false
                )
                .overlay(
                    Text(icon)
                        .font(.system(size: 58))
                )
                .frame(width: 96, height: 80)

                GamePixelText(title, size: 26)
                    .foregroundStyle(.white)
            }
            .frame(width: 205, height: 185)
            .background(GameColor.wood)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(GameColor.buttonYellow, lineWidth: 7)
            )
        }
        .buttonStyle(.plain)
    }
}

struct GameWideButton: View {
    let title: String
    let width: CGFloat
    let height: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            GamePixelText(title, size: 28)
                .foregroundStyle(.white)
                .frame(width: width, height: height)
                .background(GameColor.wood)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(GameColor.buttonYellow, lineWidth: 6)
                )
        }
        .buttonStyle(.plain)
    }
}

struct SquareChoiceButton: View {
    let symbol: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            AssetSlot(
                "choice_button",
                fill: GameColor.wood,
                cornerRadius: 16,
                showLabel: false
            )
            .overlay(
                GamePixelText(symbol, size: 52)
                    .foregroundStyle(.white)
            )
            .frame(width: 112, height: 112)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(GameColor.buttonYellow, lineWidth: 6)
            )
        }
        .buttonStyle(.plain)
    }
}

struct HelmetBadgeView: View {
    var body: some View {
        AssetSlot(
            "helmet_icon",
            fill: Color.gray.opacity(0.55),
            cornerRadius: 16,
            showLabel: true
        )
        .frame(width: 120, height: 86)
    }
}