//
//  TopHUD.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI

struct TopHUD: View {
    let onPauseTap: () -> Void

    var body: some View {
        HStack {
            HStack(spacing: 12) {
                StarBadge()

                VStack(alignment: .leading, spacing: 0) {
                    PixelText("Wave", size: 22)
                        .foregroundStyle(.white)

                    PixelText("001", size: 36)
                        .foregroundStyle(.white)
                }
            }

            Spacer()

            Button(action: onPauseTap) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(GameColor.wood)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.orange.opacity(0.35), lineWidth: 3)
                    )
                    .overlay(
                        PixelText("Ⅱ", size: 36)
                            .foregroundStyle(GameColor.parchmentLight)
                    )
                    .frame(width: 88, height: 88)
            }
        }
        .padding(.horizontal, 40)
        .padding(.top, 130)
        .frame(height: 245)
    }
}

struct StarBadge: View {
    var body: some View {
        ZStack {
            Image(systemName: "star.fill")
                .font(.system(size: 76))
                .foregroundStyle(GameColor.yellow)
                .shadow(color: GameColor.woodDark, radius: 0, x: 5, y: 5)

            Image(systemName: "star")
                .font(.system(size: 76))
                .foregroundStyle(GameColor.wood)
        }
    }
}
