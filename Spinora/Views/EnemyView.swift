//
//  Enemy.swift
//  Spinora
//
//  Created by oky faishal on 13/05/26.
//

import SpriteKit

extension GameScene {
    func enemyView() {
        setupEnemySprite()
        startEnemyIdleAnimation()
        enemyHP()
    }
    
    // Create enemy sprite once and reuse it
    private func setupEnemySprite() {
        // If already exists, do nothing
        if childNode(withName: "enemySprite") as? SKSpriteNode != nil { return }
        
        let x = frame.maxX - 60 // horizontal
        let y = frame.maxY - 120 // vertical
        
        let enemySprite = SKSpriteNode(imageNamed: "Idle 1")
        enemySprite.name = "enemySprite" // important for lookups
        enemySprite.position = CGPoint(x: x, y: y)
        enemySprite.size = CGSize(width: 100, height: 100)
        enemySprite.zPosition = 10
        addChild(enemySprite)
    }
    
    // Start or resume the enemy idle loop on the existing sprite
    func startEnemyIdleAnimation() {
        guard let enemy = childNode(withName: "enemySprite") as? SKSpriteNode else { return }
        
        // Ensure previous attack animation doesn't overlap
        enemy.removeAction(forKey: "enemyAttackAnimation")
        
        let idleFrames = [SKTexture(imageNamed: "Idle 1"), SKTexture(imageNamed: "Idle 2")]
        let animate = SKAction.animate(with: idleFrames, timePerFrame: 0.5)
        enemy.run(.repeatForever(animate), withKey: "enemyIdleAnimation")
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
    
    func playEnemyHitEffect() {
        // Find the sprite safely using its assigned name ( scope fix )
        guard let enemy = childNode(withName: "enemySprite") as? SKSpriteNode else { return }
        
        // Remove existing hit effects to prevent animation stacking
        enemy.removeAction(forKey: "hitEffect")
        
        // Ensure the base color is set to red
        enemy.color = .red
        
        // 1. Action to instantly turn the sprite fully red
        let turnRed = SKAction.run {
            enemy.colorBlendFactor = 1.0 // Fully covered by the red color
        }
        
        // 2. Action to wait for a short duration (flash duration)
        let wait = SKAction.wait(forDuration: 0.15) // Duration of the red flash
        
        // 3. Action to instantly restore the original texture appearance
        let restoreColor = SKAction.run {
            enemy.colorBlendFactor = 0.0 // Original texture is fully visible
        }
        
        // Create a sequence: Red -> Wait -> Restore
        let hitSequence = SKAction.sequence([turnRed, wait, restoreColor])
        
        // Run the sequence with a specific key
        enemy.run(hitSequence, withKey: "hitEffect")
    }
    
//    func setupEnemySprite() {
//        // ... logika setup posisi dll ...
//        let enemySprite = SKSpriteNode(imageNamed: "Idle 1")
//        enemySprite.name = "enemySprite" // SANGAT PENTING untuk Scope
//        // ... properti lainnya ...
//        addChild(enemySprite)
//    }
    
    // MARK: - Enemy Attack Animation
    func playEnemyAttackAnimation() {
        // Find the sprite safely using its assigned name
        guard let enemy = childNode(withName: "enemySprite") as? SKSpriteNode else { return }
        
        // Stop any existing actions tagged as attack to avoid overlap
        enemy.removeAction(forKey: "enemyIdleAnimation")
        
        // Load the same attack frames as the player
        let attackFrames = (1...5).map { SKTexture(imageNamed: "Attack \($0)") }
        let animateAction = SKAction.animate(with: attackFrames, timePerFrame: 0.12)
        
        // Slight lunge towards the player and back
        let moveForward = SKAction.moveBy(x: -5, y: 0, duration: 0.3)
        let moveBack = SKAction.moveBy(x: 5, y: 0, duration: 0.3)
        let moveSequence = SKAction.sequence([moveForward, moveBack])
        
        let attackGroup = SKAction.group([animateAction, moveSequence])
        
        // Return to idle after attacking by restarting idle animation
        let returnToIdle = SKAction.run { [weak self] in
            self?.startEnemyIdleAnimation()
        }
        
        enemy.run(SKAction.sequence([attackGroup, returnToIdle]), withKey: "enemyAttackAnimation")
    }
 }
