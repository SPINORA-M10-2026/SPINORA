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
            self?.playPlayerAttackAnimation()
        }
        
        // Listen for Defeat visual signal (set once)
        viewModel.onPlayerDefeatVisual = { [weak self] in
            self?.playPlayerDefeatAnimation()
            self?.messageLabel.text = "YOU LOSE!"
            self?.messageLabel.fontColor = .red
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
}

