//
//  BottomActionBarView.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//


//
//  GameButtonComponents.swift
//  Spinora
//

import SwiftUI

struct BottomActionBarView: View {
    let onAttackTap: () -> Void
    let onMenuTap: () -> Void
    let onInventoryTap: () -> Void

    var body: some View {
        HStack {
            Button(action: onMenuTap) {
                SmallSquareGameButton(icon: "☰")
            }

            Spacer()

            Button(action: onAttackTap) {
                AttackGameButton()
            }

            Spacer()

            Button(action: onInventoryTap) {
                SmallSquareGameButton(icon: "▤")
            }
        }
        .padding(.horizontal, 34)
        .padding(.bottom, 18)
        .background(GameColor.backgroundDark)
    }
}

struct SmallSquareGameButton: View {
    let icon: String

    var body: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(GameColor.wood)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(GameColor.woodDark, lineWidth: 4)
            )
            .overlay(
                GamePixelText(icon, size: 28)
                    .foregroundStyle(GameColor.parchmentLight)
            )
            .frame(width: 70, height: 70)
    }
}

struct AttackGameButton: View {
    var body: some View {
        ZStack {
            HexagonShape()
                .fill(GameColor.yellow)
                .frame(width: 230, height: 76)
                .overlay(
                    HexagonShape()
                        .stroke(GameColor.wood, lineWidth: 5)
                )
                .shadow(color: .black.opacity(0.35), radius: 0, x: 0, y: 6)

            GamePixelText("ATTACK", size: 25)
                .foregroundStyle(.white)
                .offset(y: 13)

            GamePixelText("⚔️", size: 48)
                .foregroundStyle(.white)
                .offset(y: -28)
        }
    }
}

struct RibbonBanner: View {
    let text: String

    var body: some View {
        ZStack {
            RibbonShape()
                .fill(GameColor.yellow)
                .frame(width: 620, height: 110)
                .shadow(color: GameColor.woodDark, radius: 0, x: 4, y: 6)

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
                Text(icon)
                    .font(.system(size: 78))

                GamePixelText(title, size: 26)
                    .foregroundStyle(.white)
            }
            .frame(width: 205, height: 185)
            .background(GameColor.wood)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(GameColor.yellow, lineWidth: 7)
            )
            .shadow(color: GameColor.woodDark, radius: 0, x: 6, y: 8)
        }
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
                        .stroke(GameColor.yellow, lineWidth: 6)
                )
                .shadow(color: GameColor.woodDark, radius: 0, x: 0, y: 7)
        }
    }
}

struct SquareChoiceButton: View {
    let symbol: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 16)
                .fill(GameColor.wood)
                .frame(width: 112, height: 112)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(GameColor.yellow, lineWidth: 6)
                )
                .overlay(
                    GamePixelText(symbol, size: 52)
                        .foregroundStyle(.white)
                )
                .shadow(color: GameColor.woodDark, radius: 0, x: 0, y: 7)
        }
    }
}

struct HelmetBadgeView: View {
    var body: some View {
        ZStack {
            Ellipse()
                .fill(Color.black.opacity(0.30))
                .frame(width: 130, height: 22)
                .offset(y: 42)

            HelmetShape()
                .fill(Color.gray)
                .frame(width: 120, height: 86)
                .overlay(
                    HelmetShape()
                        .stroke(.black, lineWidth: 3)
                )
        }
    }
}