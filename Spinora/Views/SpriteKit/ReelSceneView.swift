//
//  ReelSceneView.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import SwiftUI
import SpriteKit
import Combine

struct ReelSceneView: View {
    let reelColumns: [[String]]
    let reelRolledThisTurn: [Bool]
    let lastRolledIndex: Int?
    let onReelTap: (Int) -> Void

    @StateObject private var sceneStore = ReelSceneStore()

    var body: some View {
        SpriteView(
            scene: sceneStore.scene,
            options: [.allowsTransparency]
        )
        .background(Color.clear)
        .onAppear {
            sceneStore.scene.onReelTap = onReelTap

            sceneStore.scene.updateScene(
                reelColumns: reelColumns,
                reelRolledThisTurn: reelRolledThisTurn,
                animatedChangedIndex: nil
            )
        }
        .onChange(of: reelColumns) { _, newValue in
            sceneStore.scene.updateScene(
                reelColumns: newValue,
                reelRolledThisTurn: reelRolledThisTurn,
                animatedChangedIndex: lastRolledIndex
            )
        }
        .onChange(of: reelRolledThisTurn) { _, newValue in
            sceneStore.scene.updateScene(
                reelColumns: reelColumns,
                reelRolledThisTurn: newValue,
                animatedChangedIndex: lastRolledIndex
            )
        }
        .onChange(of: lastRolledIndex) { _, newValue in
            sceneStore.scene.updateScene(
                reelColumns: reelColumns,
                reelRolledThisTurn: reelRolledThisTurn,
                animatedChangedIndex: newValue
            )
        }
    }
}

final class ReelSceneStore: ObservableObject {
    let scene: ReelGameScene

    init() {
        let scene = ReelGameScene(size: CGSize(width: 670, height: 390))
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear
        self.scene = scene
    }
}
