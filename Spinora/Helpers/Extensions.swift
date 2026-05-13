//
//  Extensions.swift
//  SPINORA
//
//  Created by oky faishal on 12/05/26.
//

import SpriteKit

// MARK: - SKLabelNode Extension
extension SKLabelNode {
    
    convenience init(text: String, fontSize: CGFloat, position: CGPoint, name: String? = nil) {
        self.init(fontNamed: "HelveticaNeue-Bold")
        self.text = text
        self.fontSize = fontSize
        self.position = position
        self.name = name
        self.verticalAlignmentMode = .center
        self.horizontalAlignmentMode = .center
    }
    
    func popAnimation() {
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.1)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.1)
        self.run(SKAction.sequence([scaleUp, scaleDown]))
    }
}

// MARK: - Double Extension
extension Double {
    
    var asPercentageString: String {
        return String(format: "%.0f%%", self * 100)
    }
}

// MARK: - Array Extension
extension Array {
    
    var randomElementOrFatal: Element {
        guard let element = self.randomElement() else {
            fatalError("Array is empty")
        }
        return element
    }
}
