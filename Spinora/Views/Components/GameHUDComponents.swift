//
//  TopHUD.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI

struct HUDLayout: View {
    let waveText: String
    let onPauseTap: () -> Void

    var body: some View {
        ZStack {
            AssetSlot(
                "device_notch",
                fill: .black,
                cornerRadius: 36,
                showLabel: false
            )
            .frame(width: 260, height: 76)
            .position(x: 416, y: 70)

            AssetSlot(
                "wave_icon",
                fill: GameColor.buttonYellow.opacity(0.9),
                cornerRadius: 18
            )
            .frame(width: 95, height: 95)
            .position(x: 96, y: 165)

            VStack(alignment: .leading, spacing: 0) {
                GamePixelText("Wave", size: 28)
                GamePixelText(waveText, size: 44)
            }
            .position(x: 202, y: 174)

            Button(action: onPauseTap) {
                AssetSlot(
                    "pause_button",
                    fill: GameColor.wood,
                    cornerRadius: 20,
                    showLabel: false
                )
                .overlay(
                    GamePixelText("Ⅱ", size: 42)
                        .foregroundStyle(Color(red: 1.0, green: 0.76, blue: 0.45))
                )
            }
            .buttonStyle(.plain)
            .frame(width: 88, height: 88)
            .position(x: 742, y: 165)
        }
    }
}

struct TopFrameLayout: View {
    var body: some View {
        ZStack {
            AssetSlot(
                "top_frame",
                fill: GameColor.wood,
                cornerRadius: 0,
                showLabel: false
            )
            .frame(width: 832, height: 330)
            .position(x: 416, y: 165)

            AssetSlot(
                "top_frame_bottom_curve",
                fill: GameColor.woodDark,
                cornerRadius: 0,
                showLabel: false
            )
            .frame(width: 832, height: 36)
            .position(x: 416, y: 322)
        }
    }
}
