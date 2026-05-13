//
//  UIView.swift
//  Spinora
//
//  Created by oky faishal on 13/05/26.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func setupUI() {
        let safeAreaTop = frame.maxY - 80
        let safeAreaBottom = frame.minY + 100
        
        stageLabel = createLabel(text: "STAGE 1", fontSize: 24, pos: CGPoint(x: frame.minX + 80, y: safeAreaTop), parentNode: self)
        stageLabel.fontName = "HelveticaNeue-CondensedBlack"
    }
    
    // Helper Methods
    func createLabel(text: String, fontSize: CGFloat, pos: CGPoint, parentNode: SKNode) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        label.text = text
        label.fontSize = fontSize
        label.position = pos
        parentNode.addChild(label)
        return label
    }
    
    func createButton(text: String, color: SKColor, pos: CGPoint, name: String) -> SKShapeNode {
        let btn = SKShapeNode(rectOf: CGSize(width: 200, height: 50), cornerRadius: 10)
        btn.fillColor = color
        btn.strokeColor = .white
        btn.lineWidth = 2
        btn.position = pos
        btn.name = name
        addChild(btn)
        
        let label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        label.text = text
        label.fontSize = 22
        label.verticalAlignmentMode = .center
        label.name = name
        btn.addChild(label)
        
        return btn
    }
}
