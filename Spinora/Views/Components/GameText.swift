//
//  PixelText.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI

struct PixelText: View {
    let text: String
    let size: CGFloat

    init(_ text: String, size: CGFloat = 24) {
        self.text = text
        self.size = size
    }

    var body: some View {
        Text(text)
            .font(.system(size: size, weight: .heavy, design: .monospaced))
            .textCase(.uppercase)
            .shadow(color: GameColor.woodDark, radius: 0, x: 3, y: 3)
    }
}
