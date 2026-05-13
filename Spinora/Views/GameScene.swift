//
//  GameScene.swift
//  SPINORA
//
//  Created by oky faishal on 12/05/26.
//

import SpriteKit

class GameScene: SKScene {
    
    var viewModel: GameViewModel!
    
    // UI Nodes - Hapus kata kunci 'private' agar bisa diakses dari file extension
    var playerAtkLabel: SKLabelNode!
    var playerHpLabel: SKLabelNode!
    var enemyHpLabel: SKLabelNode!
    var enemyElementLabel: SKLabelNode!
    var stageLabel: SKLabelNode!
    
    var slotNodes: [SKShapeNode] = []
    var slotElementLabels: [SKLabelNode] = []
    var rerollButtons: [SKShapeNode] = []
    
    var spinButton: SKShapeNode!
    var attackButton: SKShapeNode!
    var messageLabel: SKLabelNode!
    
    var rewardAtkBtn: SKShapeNode!
    var rewardHpBtn: SKShapeNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 1.0)
        
        // Fungsi ini sekarang berada di file extension
        setupUI()
        
        playerView()
        enemyView()
        slotView()
        buttonAttackView()
        rewardGachaView()
        
        bindViewModel()
    }
}
