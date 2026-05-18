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
            AssetSlot(
                "bottom_frame",
                fill: GameColor.woodDark,
                cornerRadius: 0,
                showLabel: false
            )
            .frame(width: 832, height: 720)
            .position(x: 416, y: 1450)

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
    let rerollText: String
    let reelColumns: [[String]]
    let reelRolledThisTurn: [Bool]
    let lastRolledIndex: Int?
    let onGuidebookTap: () -> Void
    let onReelTap: (Int) -> Void

    var body: some View {
        ZStack {
            // Guidebook button — same horizontal line as reroll chance
            Button(action: onGuidebookTap) {
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

            // Reroll counter
            HStack(spacing: 10) {
                GamePixelText("↻", size: 34)

                GamePixelText(cleanRerollText, size: 32)
            }
            .position(x: 416, y: 1195)

            // Down arrows
            ForEach(0..<3, id: \.self) { index in
                GamePixelText("⌄", size: 32)
                    .position(
                        x: reelXPosition(index),
                        y: 1285
                    )
            }

            // SpriteKit reel panel only
            ReelSceneView(
                reelColumns: reelColumns,
                reelRolledThisTurn: reelRolledThisTurn,
                lastRolledIndex: lastRolledIndex,
                onReelTap: onReelTap
            )
            .frame(width: 670, height: 390)
            .position(x: 416, y: 1485)

            // Up arrows
            ForEach(0..<3, id: \.self) { index in
                GamePixelText("⌃", size: 32)
                    .position(
                        x: reelXPosition(index),
                        y: 1710
                    )
            }
        }
    }

    private var cleanRerollText: String {
        rerollText.replacingOccurrences(of: "↻ ", with: "")
    }

    private func reelXPosition(_ index: Int) -> CGFloat {
        switch index {
        case 0:
            return 215
        case 1:
            return 416
        case 2:
            return 617
        default:
            return 416
        }
    }
}
