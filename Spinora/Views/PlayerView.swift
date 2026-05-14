//
//  Player.swift
//  Spinora
//
//  Created by oky faishal on 13/05/26.
//

import SpriteKit

extension GameScene {
    
    func playerView() {
        setupPlayerSprite()
        startPlayerIdleAnimation()
        playerHP()
    }
    
    // MARK: - Setup UI
    
    // 1. Setup the physical sprite only once
    private func setupPlayerSprite() {
        let playerSprite = SKSpriteNode(imageNamed: "Idle 1")
        playerSprite.name = "playerSprite" // Assign a name so we can find it for hit/attack effects
        playerSprite.name = "playerSprite" // Assign a name so we can find it anywhere
        playerSprite.position = CGPoint(x: frame.minX + 60, y: frame.maxY - 350)
        playerSprite.size = CGSize(width: 100, height: 100)
        playerSprite.zPosition = 10
        addChild(playerSprite)
    }
    
    private func playerHP() {
        let x = frame.minX + 150
        let y = frame.maxY - 380
        
        playerAtkLabel = createLabel(
            text: "⚔️ ATK: 10",
            fontSize: 15,
            pos: CGPoint(x: x, y: y),
            parentNode: self
        )
        playerHpLabel = createLabel(
            text: "❤️ HP: 100",
            fontSize: 15,
            pos: CGPoint(x: x, y: y - 20),
            parentNode: self
        )
    }
    
    // MARK: - Player Animations
    
    // 2. Start or resume the looping idle animation
    func startPlayerIdleAnimation() {
        // Find the sprite safely using its assigned name
        guard let player = childNode(withName: "playerSprite") as? SKSpriteNode else { return }
        
        let idleFrames = [SKTexture(imageNamed: "Idle 1"), SKTexture(imageNamed: "Idle 2")]
        let animate = SKAction.animate(with: idleFrames, timePerFrame: 0.5)
        
        player.run(.repeatForever(animate), withKey: "idleAnimation")
    }
    
    func playPlayerAttackAnimation() {
        guard let player = childNode(withName: "playerSprite") as? SKSpriteNode else { return }
        
        // Stop idle animation to prevent conflict
        player.removeAction(forKey: "idleAnimation")
        
        // Load attack frames
        let attackFrames = (1...5).map { SKTexture(imageNamed: "Attack \($0)") }
        let animateAction = SKAction.animate(with: attackFrames, timePerFrame: 0.12)
        
        // Add slight forward/backward movement for impact
        let moveForward = SKAction.moveBy(x: 5, y: 0, duration: 0.3)
        let moveBack = SKAction.moveBy(x: -5, y: 0, duration: 0.3)
        let moveSequence = SKAction.sequence([moveForward, moveBack])
        
        // Group animation and movement to run simultaneously
//        let attackGroup = SKAction.group([animateAction])
        let attackGroup = SKAction.group([animateAction, moveSequence])
        
        // Return to idle after attacking
        let returnToIdle = SKAction.run { [weak self] in
            self?.startPlayerIdleAnimation()
        }
        
        player.run(SKAction.sequence([attackGroup, returnToIdle]))
    }
    
    func playPlayerDefeatAnimation() {
        guard let player = childNode(withName: "playerSprite") as? SKSpriteNode else { return }
        
        // Stop all current actions (idle, attacks, etc)
        player.removeAllActions()
        
        // Load defeat frames
        let deadFrames = (1...7).map { SKTexture(imageNamed: "Dead \($0)") }
        let animateAction = SKAction.animate(with: deadFrames, timePerFrame: 0.15, resize: false, restore: false)
        
        // Add fall over rotation effect
        let fallOver = SKAction.rotate(toAngle: .pi / 2, duration: 0.5)
        
        let deathGroup = SKAction.group([animateAction, fallOver])
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
        
        player.run(SKAction.sequence([deathGroup, fadeOut]))
    }
    
    // MARK: - Helpers
    
    // Helper function to load textures from asset names dynamically
    private func loadTextures(baseName: String, frameCount: Int) -> [SKTexture] {
        var textures: [SKTexture] = []
        for i in 1...frameCount {
            textures.append(SKTexture(imageNamed: "\(baseName)_\(i)"))
        }
        return textures
    }
}

