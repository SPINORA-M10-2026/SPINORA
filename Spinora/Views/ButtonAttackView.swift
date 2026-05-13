//
//  ButtonAttack.swift
//  Spinora
//
//  Created by oky faishal on 13/05/26.
//

import Foundation
import SpriteKit

extension GameScene {
    func buttonAttackView () {
        let safeAreaTop = frame.maxY - 80
        let safeAreaBottom = frame.minY + 100
        
        spinButton = createButton(text: "SPIN ALL", color: SKColor(red: 0.2, green: 0.6, blue: 0.3, alpha: 1.0), pos: CGPoint(x: frame.midX, y: safeAreaBottom + 50), name: "spin")
        
        attackButton = createButton(text: "ATTACK", color: SKColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1.0), pos: CGPoint(x: frame.midX, y: safeAreaBottom - 20), name: "attack")
        
        messageLabel = createLabel(text: "Ready?", fontSize: 22, pos: CGPoint(x: frame.midX, y: frame.midY - 70), parentNode: self)
        messageLabel.fontColor = .yellow
    }
}
