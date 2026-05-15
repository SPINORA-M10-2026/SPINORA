//
//  ReelPanel.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI

struct BottomFrameLayout: View {
    var body: some View {
        ZStack {
            // Bottom frame asset slot
            AssetSlot(
                "bottom_frame",
                fill: GameColor.woodDark,
                cornerRadius: 0,
                showLabel: false
            )
            .frame(width: 832, height: 720)
            .position(x: 416, y: 1450)

            // Top rim / bridge between arena and reel panel
            AssetSlot(
                "bottom_frame_top_curve",
                fill: GameColor.wood,
                cornerRadius: 0,
                showLabel: false
            )
            .frame(width: 832, height: 96)
            .position(x: 416, y: 1128)
        }
    }
}

struct ReelLayout: View {
    private let reelColumns: [[String]] = [
        ["💧", "🔥", "🔥"],
        ["🔥", "💧", "🪨"],
        ["🪨", "🪨", "💧"]
    ]

    var body: some View {
        ZStack {
            // Single guidebook button, same horizontal line as reroll chance
            Button {
                print("Guidebook tapped")
            } label: {
                AssetSlot(
                    "guidebook_button",
                    fill: GameColor.wood,
                    cornerRadius: 16,
                    showLabel: false
                )
                .overlay(
                    GamePixelText("☰", size: 28)
                        .foregroundStyle(Color(red: 1.0, green: 0.75, blue: 0.45))
                )
            }
            .buttonStyle(.plain)
            .frame(width: 82, height: 82)
            .position(x: 60, y: 1195)

            // Reroll chance, centered
            HStack(spacing: 10) {
                GamePixelText("↻", size: 34)
                GamePixelText("2/3", size: 32)
            }
            .position(x: 416, y: 1195)

            // Down arrows above each reel
            ForEach(0..<3, id: \.self) { index in
                GamePixelText("⌄", size: 32)
                    .position(
                        x: [215, 416, 617][index],
                        y: 1268
                    )
            }

            // Reel background container slot
            AssetSlot(
                "reel_panel_background",
                fill: GameColor.wood,
                cornerRadius: 28,
                showLabel: false
            )
            .frame(width: 670, height: 390)
            .position(x: 416, y: 1460)

            // Reel columns
            ForEach(0..<3, id: \.self) { index in
                ReelColumnSlot(symbols: reelColumns[index])
                    .frame(width: 190, height: 315)
                    .position(
                        x: [215, 416, 617][index],
                        y: 1460
                    )
            }

            // Tap to play text placeholder
            AssetSlot(
                "tap_to_play_text",
                fill: Color.clear,
                cornerRadius: 0,
                showLabel: false
            )
            .overlay(
                GamePixelText("TAP TO PLAY!", size: 40)
                    .foregroundStyle(.white.opacity(0.88))
            )
            .frame(width: 420, height: 70)
            .position(x: 416, y: 1470)

            // Up arrows below each reel
            ForEach(0..<3, id: \.self) { index in
                GamePixelText("⌃", size: 32)
                    .position(
                        x: [215, 416, 617][index],
                        y: 1708
                    )
            }
        }
    }
}

struct ReelColumnSlot: View {
    let symbols: [String]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(symbols.indices, id: \.self) { index in
                ZStack {
                    Rectangle()
                        .fill(index == 1 ? GameColor.reelLight : GameColor.reelMid.opacity(0.75))

                    Text(symbols[index])
                        .font(.system(size: index == 1 ? 54 : 38))
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(GameColor.woodDark, lineWidth: 7)
        )
        .overlay(
            AssetSlot(
                "reel_column_png",
                fill: Color.clear,
                cornerRadius: 16,
                showLabel: false
            )
            .allowsHitTesting(false)
        )
    }
}
