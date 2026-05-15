//
//  GameBattleView.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI

struct GameBattleView: View {
    private let designWidth: CGFloat = 832
    private let designHeight: CGFloat = 1800

    var body: some View {
        GeometryReader { geo in
            let screenWidth = geo.size.width
            let screenHeight = geo.size.height

            let scale = min(
                screenWidth / designWidth,
                screenHeight / designHeight
            )

            let fittedWidth = designWidth * scale
            let fittedHeight = designHeight * scale

            ZStack {
                GameColor.screenBackground
                    .ignoresSafeArea()

                gameCanvas
                    .frame(width: designWidth, height: designHeight)
                    .scaleEffect(scale)
                    .frame(width: fittedWidth, height: fittedHeight)
                    .position(
                        x: screenWidth / 2,
                        y: screenHeight / 2
                    )
            }
            .frame(width: screenWidth, height: screenHeight)
        }
        .ignoresSafeArea()
    }

    private var gameCanvas: some View {
        ZStack {
            TopFrameLayout()
            ArenaLayout()
            BottomFrameLayout()
            ReelLayout()
            BottomButtonLayout()
            HUDLayout()
        }
        .frame(width: designWidth, height: designHeight)
        .clipped()
    }
}
