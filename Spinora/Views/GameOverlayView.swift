//
//  GameOverlayType.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI

enum GameOverlayType {
    case waveCleared
    case pause
    case confirmation
}

enum ConfirmAction {
    case restartWave
    case resetGame

    var title: String {
        switch self {
        case .restartWave:
            return "ARE YOU SURE YOU WANT TO RESTART FROM WAVE 1?"
        case .resetGame:
            return "ARE YOU SURE YOU WANT TO RESET GAME?"
        }
    }
}

enum RewardChoice: String {
    case hp = "+10% HP"
    case attack = "+10% ATK"
}

struct GameOverlayView: View {
    let overlay: GameOverlayType
    let confirmAction: ConfirmAction?

    let onRewardSelected: (RewardChoice) -> Void
    let onOK: () -> Void
    let onResume: () -> Void
    let onRestartWave: () -> Void
    let onResetGame: () -> Void
    let onConfirm: () -> Void
    let onCancel: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.66)
                .ignoresSafeArea()

            switch overlay {
            case .waveCleared:
                WaveClearedOverlay(
                    onHP: {
                        onRewardSelected(.hp)
                    },
                    onAttack: {
                        onRewardSelected(.attack)
                    },
                    onOK: onOK
                )

            case .pause:
                PauseOverlay(
                    onResume: onResume,
                    onRestartWave: onRestartWave,
                    onResetGame: onResetGame
                )

            case .confirmation:
                ConfirmationOverlay(
                    title: confirmAction?.title ?? "ARE YOU SURE?",
                    onConfirm: onConfirm,
                    onCancel: onCancel
                )
            }
        }
    }
}

// MARK: - Wave Cleared

private struct WaveClearedOverlay: View {
    let onHP: () -> Void
    let onAttack: () -> Void
    let onOK: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            RibbonBanner(text: "WAVE CLEARED!")

            GamePixelText("pick your reward", size: 25)
                .foregroundStyle(.white)

            HStack(spacing: 0) {
                RewardCardView(
                    icon: "button_reward_hp_default",
                    title: "+10% HP",
                    action: onHP
                )

                RewardCardView(
                    icon: "button_reward_atk_default",
                    title: "+10% ATK",
                    action: onAttack
                )
            }

//            GameWideButton(
//                title: "OK",
//                width: 230,
//                height: 68,
//                action: onOK
//            )
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Pause

private struct PauseOverlay: View {
    let onResume: () -> Void
    let onRestartWave: () -> Void
    let onResetGame: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HelmetBadgeView()
                .offset(y: 26)
                .zIndex(2)

            VStack(spacing: 26) {
                GameWideButton(
                    title: "RESUME",
                    width: 420,
                    height: 76,
                    action: onResume
                )

                GameWideButton(
                    title: "RESTART WAVE",
                    width: 420,
                    height: 76,
                    action: onRestartWave
                )

                GameWideButton(
                    title: "RESET GAME",
                    width: 420,
                    height: 76,
                    action: onResetGame
                )
            }
            .padding(.horizontal, 34)
            .padding(.vertical, 48)
            .background(GameColor.wood)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(GameColor.wood, lineWidth: 18)
            )
            .shadow(color: .black.opacity(0.45), radius: 0, x: 0, y: 12)
        }
        .padding(.horizontal, 26)
    }
}

// MARK: - Confirmation

private struct ConfirmationOverlay: View {
    let title: String
    let onConfirm: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HelmetBadgeView()
                .offset(y: 26)
                .zIndex(2)

            VStack(spacing: 32) {
                GamePixelText(title, size: 28)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.55)
                    .padding(.horizontal, 12)

                HStack(spacing: 80) {
                    SquareChoiceButton(
                        symbol: "✓",
                        action: onConfirm
                    )

                    SquareChoiceButton(
                        symbol: "✕",
                        action: onCancel
                    )
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 48)
            .background(GameColor.wood)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(GameColor.wood, lineWidth: 18)
            )
            .shadow(color: .black.opacity(0.45), radius: 0, x: 0, y: 12)
        }
        .padding(.horizontal, 26)
    }
}
