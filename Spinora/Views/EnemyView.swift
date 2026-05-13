//
//  Enemy.swift
//  Spinora
//
//  Created by oky faishal on 13/05/26.
//

import SpriteKit

extension GameScene {
    func enemyView() {
        enemyIdleAnimation()
        enemyHP()
    }
    
    func enemyIdleAnimation () {
        let x = frame.maxX - 60 // horizontal
        let y = frame.maxY - 120 // vertical
        
        // setup
        let playerSprite = SKSpriteNode(imageNamed: "Idle 1")
        playerSprite.position = CGPoint(x: x, y: y)
        playerSprite.size = CGSize(width: 100, height: 100)
        playerSprite.zPosition = 10
        addChild(playerSprite)
        
        // animation
        let idleFrames = [SKTexture(imageNamed: "Idle 1"), SKTexture(imageNamed: "Idle 2")]
        let animate = SKAction.animate(with: idleFrames, timePerFrame: 0.5)
        
        playerSprite.run(.repeatForever(animate), withKey: "EnemydleAnimation")
    }
    
    func enemyHP () {
        let x = frame.maxX - 150 // horizontal
        let y = frame.maxY - 100 // vertical
        
        enemyHpLabel = createLabel(
            text: "HP: 50 ❤️",
            fontSize: 15,
            pos: CGPoint(x: x, y: y),
            parentNode: self
        )
        
        enemyElementLabel = createLabel(
            text: "Weak: 🔥",
            fontSize: 15,
            pos: CGPoint(x: x, y: y - 20),
            parentNode: self
        )
    }
 }
