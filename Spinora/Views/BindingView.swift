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
        viewModel.onSlotsUpdated = { [weak self] animatedIndices in
            guard let self = self else { return }
            
            for (index, slot) in self.viewModel.slotsPresentation.enumerated() {
                
                // 2. CEK apakah slot ini ada di daftar yang harus dianimasikan
                if animatedIndices.contains(index) {
                    // Jika ya, jalankan animasi spin
                    self.animateSpin(for: index, finalEmoji: slot.emoji)
                } else {
                    // Jika tidak, cukup pastikan teks emojinya benar tanpa animasi
                    self.slotElementLabels[index].text = slot.emoji
                }
                
                // Update visual tombol REROLL
                // (Catatan: perhatikan penambahan as? SKShapeNode agar aman)
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
        
//        viewModel.onSlotsUpdated = { [weak self] in
//            guard let self = self else { return }
//            for (index, slot) in self.viewModel.slotsPresentation.enumerated() {
////                self.slotElementLabels[index].text = slot.emoji
//                self.animateSpin(for: index, finalEmoji: slot.emoji)
//                
//                if let btn = self.rerollButtons[index] as SKShapeNode?,
//                   let label = btn.children.first as? SKLabelNode {
//                    
//                    if slot.isMaxed {
//                        btn.fillColor = .gray
//                    } else {
//                        btn.fillColor = SKColor(red: 0.8, green: 0.3, blue: 0.2, alpha: 1.0)
//                    }
//                    label.text = slot.buttonText
//                }
//                
////                if let btn = self.rerollButtons[index] as SKShapeNode?,
////                   let label = btn.children.first as? SKLabelNode {
////                    
////                    if slot.isMaxed {
////                        btn.fillColor = .gray
////                    } else {
////                        btn.fillColor = SKColor(red: 0.8, green: 0.3, blue: 0.2, alpha: 1.0)
////                    }
////                    label.text = slot.buttonText
////                }
//            }
//        }
        
        viewModel.onStatsUpdated = { [weak self] in
            guard let self = self, let vm = self.viewModel else { return }
            self.playerAtkLabel.text = "⚔️ ATK: \(vm.player.baseAttack)"
            self.playerHpLabel.text = "❤️ HP: \(vm.player.hp)"
            self.enemyHpLabel.text = "HP: \(vm.enemy.hp) ❤️"
            self.enemyElementLabel.text = "Weak: \(vm.enemy.element?.emoji ?? "❓")"
            self.stageLabel.text = "STAGE \(vm.currentStage)"
        }
        
        viewModel.onMessage = { [weak self] msg in
            self?.messageLabel.text = msg
            self?.messageLabel.setScale(1.5)
            self?.messageLabel.run(SKAction.scale(to: 1.0, duration: 0.3))
        }
        
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
        
        viewModel.onStateChanged = { [weak self] state in
            self?.updateButtonVisibility(for: state)
        }
        
        viewModel.onStatsUpdated?()
//        viewModel.onSlotsUpdated?()
        viewModel.onSlotsUpdated?([])
        updateButtonVisibility(for: viewModel.state)
    }
    
    func updateButtonVisibility(for state: GameState) {
        spinButton.alpha = 0.0
        attackButton.alpha = 0.0
        rerollButtons.forEach { $0.alpha = 0.0 }
        rewardAtkBtn.alpha = 0.0
        rewardHpBtn.alpha = 0.0
        
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
