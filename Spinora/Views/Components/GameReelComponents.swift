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
                Image("button_element_book")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(18)
            }
            .buttonStyle(.plain)
            .frame(height: 270)
            .position(x: 10, y: 1195)

            // Reroll counter
            HStack(spacing: 10) {
                Image("icon_reroll_images")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)

                GamePixelText(cleanRerollText, size: 32)
            }
            .position(x: 416, y: 1195)

            // Down arrows
            ZStack {
                // SpriteKit reel panel only
                ReelSceneView(
                    reelColumns: reelColumns,
                    reelRolledThisTurn: reelRolledThisTurn,
                    lastRolledIndex: lastRolledIndex,
                    onReelTap: onReelTap
                )
                .frame(width: 670, height: 390)
                .position(x: 416, y: 1485)
                .zIndex(10)
                
                Image("background_jackpot_arrow_blink")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 850)
                    .zIndex(15)
                    .position(x: 416, y: 890)
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
