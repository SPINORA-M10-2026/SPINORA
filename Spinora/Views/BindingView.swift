//
//  BindingView.swift
//  Spinora
//
//  Created by oky faishal on 13/05/26.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func bindViewModel() {
        // Update slot UI when slots change
        viewModel.onSlotsUpdated = { [weak self] animatedIndices in
            guard let self = self else { return }
            
            for (index, slot) in self.viewModel.slotsPresentation.enumerated() {
                // Animate only the indices requested, otherwise update directly
                if animatedIndices.contains(index) {
                    self.animateSpin(for: index, finalEmoji: slot.emoji)
                } else {
                    self.slotElementLabels[index].text = slot.emoji
                }
                
                // Update reroll button visual state
                if let btn = self.rerollButtons[index] as? SKShapeNode,
                   let label = btn.children.first as? SKLabelNode {
                    if slot.isMaxed {
                        btn.fillColor = .gray
                    } else {
                        btn.fillColor = SKColor(red: 0.8, green: 0.3, blue: 0.2, alpha: 1.0)
                    }
                    label.text = slot.buttonText
                }
            }
        }
        
        // Listen for Attack visual signal (set once)
        viewModel.onPlayerAttackVisual = { [weak self] in
            guard let self = self else { return }
            // Play the player's melee animation
            self.playPlayerAttackAnimation()
            // Launch a simple projectile from player to enemy; duration matches ViewModel's 0.35s delay
            self.launchProjectile(fromNodeNamed: "playerSprite", toNodeNamed: "enemySprite", color: SKColor.cyan, duration: 0.35)
        }
        
        // Listen for Defeat visual signal (set once)
        viewModel.onPlayerDefeatVisual = { [weak self] in
            self?.playPlayerDefeatAnimation()
            self?.messageLabel.text = "YOU LOSE!"
            self?.messageLabel.fontColor = .red
        }
        
        // Listen for Enemy attack visual (set once)
        viewModel.onEnemyAttackVisual = { [weak self] in
            guard let self = self else { return }
            // Small pre-attack delay to telegraph the enemy attack
            let delay = SKAction.wait(forDuration: 0.2)
            let perform = SKAction.run { [weak self] in
                self?.playEnemyAttackAnimation()
                // Launch projectile to match the overall slowed timing (0.35)
                self?.launchProjectile(fromNodeNamed: "enemySprite", toNodeNamed: "playerSprite", color: SKColor.orange, duration: 0.35)
            }
            self.run(SKAction.sequence([delay, perform]))
        }
        
        // Listen for Player hit visual (set once)
        viewModel.onPlayerHitVisual = { [weak self] in
            // Flash the player sprite red briefly to indicate damage
            guard let self = self,
                  let player = self.childNode(withName: "playerSprite") as? SKSpriteNode else { return }
            
            player.removeAction(forKey: "playerHit")
            player.color = .red
            let turnRed = SKAction.run { player.colorBlendFactor = 1.0 }
            let wait = SKAction.wait(forDuration: 0.15)
            let restore = SKAction.run { player.colorBlendFactor = 0.0 }
            player.run(SKAction.sequence([turnRed, wait, restore]), withKey: "playerHit")
        }
        
        // Listen for Enemy hit visual (set once)
        viewModel.onEnemyHitVisual = { [weak self] in
            self?.playEnemyHitEffect()
        }
        
        // Stats update binding
        viewModel.onStatsUpdated = { [weak self] in
            guard let self = self, let vm = self.viewModel else { return }
            
            self.playerAtkLabel.text = "⚔️ ATK: \(vm.player.baseAttack)"
            self.playerHpLabel.text = "❤️ HP: \(vm.player.hp)"
            self.enemyHpLabel.text = "HP: \(vm.enemy.hp) ❤️"
            self.enemyElementLabel.text = "Weak: \(vm.enemy.element?.emoji ?? "❓")"
            self.stageLabel.text = "STAGE \(vm.currentStage)"
        }
        
        // Message binding
        viewModel.onMessage = { [weak self] msg in
            self?.messageLabel.text = msg
            self?.messageLabel.setScale(1.5)
            self?.messageLabel.run(SKAction.scale(to: 1.0, duration: 0.3))
        }
        
        // Reward ready binding
        viewModel.onRewardReady = { [weak self] in
            guard let self = self else { return }
            
            if let atkLabel = self.rewardAtkBtn.children.first as? SKLabelNode {
                atkLabel.text = self.viewModel.rewardAtkText
            }
            if let hpLabel = self.rewardHpBtn.children.first as? SKLabelNode {
                hpLabel.text = self.viewModel.rewardHpText
            }
            
            self.messageLabel.text = "Pilih Bonus Gacha!"
        }
        
        // State change -> update button visibility
        viewModel.onStateChanged = { [weak self] state in
            self?.updateButtonVisibility(for: state)
        }
        
        // Initial state setups (called once, outside any callback to avoid recursion)
        viewModel.onStatsUpdated?()
        viewModel.onSlotsUpdated?([])
        updateButtonVisibility(for: viewModel.state)
    }
    
    func updateButtonVisibility(for state: GameState) {
        // Reset all button visibilities
        spinButton.alpha = 0.0
        attackButton.alpha = 0.0
        rerollButtons.forEach { $0.alpha = 0.0 }
        rewardAtkBtn.alpha = 0.0
        rewardHpBtn.alpha = 0.0
        
        // Set visibility based on the current game state
        switch state {
        case .idle:
            spinButton.alpha = 1.0
            attackButton.alpha = 0.3
            rerollButtons.forEach { $0.alpha = 0.3 }
        case .playerTurn:
            spinButton.alpha = 0.3
            attackButton.alpha = 1.0
            rerollButtons.forEach { $0.alpha = 1.0 }
        case .rewardSelection:
            rewardAtkBtn.alpha = 1.0
            rewardHpBtn.alpha = 1.0
        default:
            break
        }
    }
    
    // MARK: - Simple Projectile Helper
    private func launchProjectile(fromNodeNamed startName: String, toNodeNamed endName: String, color: SKColor, duration: TimeInterval) {
        guard let startNode = childNode(withName: startName) as? SKSpriteNode,
              let endNode = childNode(withName: endName) as? SKSpriteNode else { return }
        
        // Create a simple circular projectile
        let projectile = SKShapeNode(circleOfRadius: 6)
        projectile.fillColor = color
        projectile.strokeColor = .clear
        projectile.position = startNode.position
        projectile.zPosition = 20
        addChild(projectile)
        
        // Animate towards the target and remove on impact
        let move = SKAction.move(to: endNode.position, duration: duration)
        let fadeOut = SKAction.fadeOut(withDuration: 0.05)
        let remove = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([move, fadeOut, remove]))
    }
}
