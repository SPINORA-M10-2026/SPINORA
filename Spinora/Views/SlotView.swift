//
//  SlotView.swift
//  Spinora
//
//  Created by oky faishal on 13/05/26.
//

import Foundation

import SpriteKit

extension GameScene {
    func slotView () {
        let slotSpacing: CGFloat = 100
        let startX = frame.midX - slotSpacing
        
        for i in 0..<3 {
            // Kotak Slot
            let slotBox = SKShapeNode(rectOf: CGSize(width: 80, height: 80), cornerRadius: 8)
            slotBox.fillColor = .darkGray
            slotBox.strokeColor = .white
            slotBox.lineWidth = 3
            // Typo 13a0 diperbaiki menjadi 130
            slotBox.position = CGPoint(x: startX + (CGFloat(i) * slotSpacing), y: frame.midY - 130)
            addChild(slotBox)
            slotNodes.append(slotBox)
            
            // Ikon Elemen
            let elementIcon = createLabel(text: "❓", fontSize: 40, pos: .zero, parentNode: slotBox)
            elementIcon.verticalAlignmentMode = .center
            slotElementLabels.append(elementIcon)
            
            // Tombol Lock/Reroll
            let rerollBtn = SKShapeNode(rectOf: CGSize(width: 60, height: 30), cornerRadius: 5)
            rerollBtn.fillColor = SKColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
            rerollBtn.position = CGPoint(x: slotBox.position.x, y: slotBox.position.y - 70)
            rerollBtn.name = "reroll_\(i)"
            addChild(rerollBtn)
            rerollButtons.append(rerollBtn)
            
            // Teks Tombol Lock
            let rerollText = createLabel(text: "REROLL", fontSize: 14, pos: .zero, parentNode: rerollBtn)
            rerollText.verticalAlignmentMode = .center
            rerollText.name = "reroll_\(i)"
        }
    }
}
