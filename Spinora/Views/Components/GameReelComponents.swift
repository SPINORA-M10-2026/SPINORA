//
//  ReelPanel.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI

struct ReelPanel: View {
    private let columns: [[String]] = [
        ["💧", "🔥", "🔥"],
        ["🔥", "💧", "🪨"],
        ["🪨", "🪨", "💧"]
    ]

    var body: some View {
        VStack(spacing: 14) {
            HStack {
                ForEach(0..<3, id: \.self) { _ in
                    PixelText("⌄", size: 34)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                }
            }

            HStack(spacing: 14) {
                ForEach(0..<3, id: \.self) { index in
                    ReelColumn(symbols: columns[index])
                }
            }
            .padding(.horizontal, 34)
            .padding(.vertical, 26)
            .background(GameColor.wood)
            .clipShape(RoundedRectangle(cornerRadius: 28))
            .shadow(color: .black.opacity(0.4), radius: 0, x: 0, y: 14)

            HStack {
                ForEach(0..<3, id: \.self) { _ in
                    PixelText("⌃", size: 34)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 48)
        .padding(.bottom, 12)
    }
}

struct ReelColumn: View {
    let symbols: [String]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(symbols.indices, id: \.self) { index in
                Text(symbols[index])
                    .font(.system(size: index == 1 ? 58 : 42))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(index == 1 ? GameColor.parchmentLight : GameColor.parchment)
            }
        }
        .frame(height: 240)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(GameColor.woodDark, lineWidth: 7)
        )
    }
}
