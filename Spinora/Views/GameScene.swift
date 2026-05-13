//
//  GameScene.swift
//  SPINORA
//
//  Created by oky faishal on 12/05/26.
//

import SpriteKit

class GameScene: SKScene {
    
    var viewModel: GameViewModel!
    
    // UI Nodes
    private var playerAtkLabel: SKLabelNode!
    private var playerHpLabel: SKLabelNode!
    private var enemyHpLabel: SKLabelNode!
    private var enemyElementLabel: SKLabelNode!
    private var stageLabel: SKLabelNode!
    
    private var slotNodes: [SKShapeNode] = []
    private var slotElementLabels: [SKLabelNode] = []
    private var rerollButtons: [SKShapeNode] = []
    
    private var spinButton: SKShapeNode!
    private var attackButton: SKShapeNode!
    private var messageLabel: SKLabelNode!
    
    private var rewardAtkBtn: SKShapeNode!
    private var rewardHpBtn: SKShapeNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.2, alpha: 1.0)
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        let safeAreaTop = frame.maxY - 80
        let safeAreaBottom = frame.minY + 100
        
        // 1. TOP HUD (Ditambahkan ke 'self' alias layar utama)
        playerAtkLabel = createLabel(text: "⚔️ ATK: 10", fontSize: 20, pos: CGPoint(x: frame.minX + 80, y: safeAreaTop), parentNode: self)
        playerHpLabel = createLabel(text: "❤️ HP: 100", fontSize: 20, pos: CGPoint(x: frame.minX + 80, y: safeAreaTop - 30), parentNode: self)
        
        stageLabel = createLabel(text: "STAGE 1", fontSize: 24, pos: CGPoint(x: frame.midX, y: safeAreaTop - 15), parentNode: self)
        stageLabel.fontName = "HelveticaNeue-CondensedBlack"
        
        enemyHpLabel = createLabel(text: "HP: 50 ❤️", fontSize: 20, pos: CGPoint(x: frame.maxX - 80, y: safeAreaTop), parentNode: self)
        enemyElementLabel = createLabel(text: "Weak: 🔥", fontSize: 20, pos: CGPoint(x: frame.maxX - 80, y: safeAreaTop - 30), parentNode: self)
        
        // 2. CENTER SLOTS
        let slotSpacing: CGFloat = 100
        let startX = frame.midX - slotSpacing
        
        for i in 0..<3 {
            // Kotak Slot
            let slotBox = SKShapeNode(rectOf: CGSize(width: 80, height: 80), cornerRadius: 8)
            slotBox.fillColor = .darkGray
            slotBox.strokeColor = .white
            slotBox.lineWidth = 3
            slotBox.position = CGPoint(x: startX + (CGFloat(i) * slotSpacing), y: frame.midY + 50)
            addChild(slotBox)
            slotNodes.append(slotBox)
            
            // Ikon Elemen (Ditambahkan ke dalam 'slotBox')
            let elementIcon = createLabel(text: "❓", fontSize: 40, pos: .zero, parentNode: slotBox)
            elementIcon.verticalAlignmentMode = .center
            slotElementLabels.append(elementIcon)
            
            // Tombol Lock/Reroll
            let rerollBtn = SKShapeNode(rectOf: CGSize(width: 60, height: 30), cornerRadius: 5)
            rerollBtn.fillColor = SKColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
            rerollBtn.position = CGPoint(x: slotBox.position.x, y: slotBox.position.y - 70)
            rerollBtn.name = "reroll_\(i)"
            addChild(rerollBtn)
            rerollButtons.append(rerollBtn)
            
            // Teks Tombol Lock (Ditambahkan ke dalam 'rerollBtn')
            let rerollText = createLabel(text: "REROLL", fontSize: 14, pos: .zero, parentNode: rerollBtn)
            rerollText.verticalAlignmentMode = .center
            rerollText.name = "reroll_\(i)"
        }
        
        // 3. BOTTOM BUTTONS
        spinButton = createButton(text: "SPIN ALL", color: SKColor(red: 0.2, green: 0.6, blue: 0.3, alpha: 1.0), pos: CGPoint(x: frame.midX, y: safeAreaBottom + 80), name: "spin")
        
        attackButton = createButton(text: "ATTACK", color: SKColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1.0), pos: CGPoint(x: frame.midX, y: safeAreaBottom + 10), name: "attack")
        
        messageLabel = createLabel(text: "Ready?", fontSize: 22, pos: CGPoint(x: frame.midX, y: frame.midY - 70), parentNode: self)
        messageLabel.fontColor = .yellow
        
        // 4. REWARD BUTTONS (Sembunyikan di awal)
        rewardAtkBtn = createButton(text: "+? ATK", color: SKColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1.0), pos: CGPoint(x: frame.midX - 110, y: frame.midY), name: "reward_atk")
        rewardAtkBtn.alpha = 0.0
        
        rewardHpBtn = createButton(text: "+? HP", color: SKColor(red: 0.2, green: 0.8, blue: 0.5, alpha: 1.0), pos: CGPoint(x: frame.midX + 110, y: frame.midY), name: "reward_hp")
        rewardHpBtn.alpha = 0.0
    }
    
    // PERBAIKAN: Menambahkan parameter `parentNode`
    private func createLabel(text: String, fontSize: CGFloat, pos: CGPoint, parentNode: SKNode) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        label.text = text
        label.fontSize = fontSize
        label.position = pos
        parentNode.addChild(label) // Menempelkan label ke target yang benar
        return label
    }
    
    private func createButton(text: String, color: SKColor, pos: CGPoint, name: String) -> SKShapeNode {
        let btn = SKShapeNode(rectOf: CGSize(width: 200, height: 50), cornerRadius: 10)
        btn.fillColor = color
        btn.strokeColor = .white
        btn.lineWidth = 2
        btn.position = pos
        btn.name = name
        addChild(btn)
        
        let label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        label.text = text
        label.fontSize = 22
        label.verticalAlignmentMode = .center
        label.name = name
        btn.addChild(label)
        
        return btn
    }
    
    private func bindViewModel() {
        viewModel.onSlotsUpdated = { [weak self] in
            guard let self = self else { return }
            for (index, slot) in self.viewModel.slotsPresentation.enumerated() {
                // Update emoji slot
                self.slotElementLabels[index].text = slot.emoji
                
                // Update visual tombol REROLL
                if let btn = self.rerollButtons[index] as SKShapeNode?,
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
        viewModel.onSlotsUpdated?()
        updateButtonVisibility(for: viewModel.state)
    }
    
    private func updateButtonVisibility(for state: GameState) {
        // Reset Alpha Semua
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
            // Hanya tampilkan tombol reward
            rewardAtkBtn.alpha = 1.0
            rewardHpBtn.alpha = 1.0
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let tappedNodes = nodes(at: location)
        for node in tappedNodes {
            guard let name = node.name else { continue }
            
            let pressAction = SKAction.sequence([SKAction.scale(to: 0.9, duration: 0.1), SKAction.scale(to: 1.0, duration: 0.1)])
            
            if name == "reward_atk" {
                node.run(pressAction)
                viewModel.intentSelectReward(increaseATK: true)
                return // Mencegah klik lebih dari satu node bertumpuk
            } else if name == "reward_hp" {
                node.run(pressAction)
                viewModel.intentSelectReward(increaseATK: false)
                return
            } else if name == "spin" {
                node.run(pressAction)
                viewModel.intentSpinAll()
            } else if name == "attack" {
                node.run(pressAction)
                viewModel.intentAttack()
            } else if name.hasPrefix("reroll_") {
                node.run(pressAction)
                let indexStr = name.replacingOccurrences(of: "reroll_", with: "")
                if let index = Int(indexStr) {
                    viewModel.intentRerollSlot(at: index)
                }
            }
        }
    }
}

