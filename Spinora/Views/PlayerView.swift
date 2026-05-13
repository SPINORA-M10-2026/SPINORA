//
//  Player.swift
//  Spinora
//
//  Created by oky faishal on 13/05/26.
//

import SpriteKit

extension GameScene {
    func playerView() {
        playerIdleAnimation()
        playerHP()
    }
    
    func playerIdleAnimation () {
        let x = frame.minX + 60 // horizontal
        let y = frame.maxY - 350 // vertical
        
        // setup
        let enemySprite = SKSpriteNode(imageNamed: "Idle 1")
        enemySprite.position = CGPoint(x: x, y: y)
        enemySprite.size = CGSize(width: 100, height: 100)
        enemySprite.zPosition = 10
        addChild(enemySprite)
        
        // animation
        let idleFrames = [SKTexture(imageNamed: "Idle 1"), SKTexture(imageNamed: "Idle 2")]
        let animate = SKAction.animate(with: idleFrames, timePerFrame: 0.5)
        
        enemySprite.run(.repeatForever(animate), withKey: "PlayerdleAnimation")
    }
    
    func playerHP () {
        let x = frame.minX + 150 // horizontal
        let y = frame.maxY - 380 // vertical
        
        playerHpLabel = createLabel(
            text: "⚔️ ATK: 10",
            fontSize: 15,
            pos: CGPoint(x: x, y: y),
            parentNode: self
        )
        
        playerAtkLabel = createLabel(
            text: "❤️ HP: 100",
            fontSize: 15,
            pos: CGPoint(x: x, y: y - 20),
            parentNode: self
        )
    }
 }
