//
//  AssetSlot.swift
//  Spinora
//

import SwiftUI

struct AssetSlot: View {
    let name: String
    let fill: Color
    let cornerRadius: CGFloat
    let showLabel: Bool

    init(
        _ name: String,
        fill: Color = GameColor.placeholder,
        cornerRadius: CGFloat = 10,
        showLabel: Bool = true
    ) {
        self.name = name
        self.fill = fill
        self.cornerRadius = cornerRadius
        self.showLabel = showLabel
    }

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(fill)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(GameColor.placeholderStroke, lineWidth: 1.5)
            )
            .overlay {
                if showLabel {
                    Text(name)
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundStyle(.white.opacity(0.75))
                        .multilineTextAlignment(.center)
                        .padding(4)
                }
            }
    }
}