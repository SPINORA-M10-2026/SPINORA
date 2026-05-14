//
//  GameViewModel.swift
//  SPINORA
//
//  Created by oky faishal on 12/05/26.
//

import Foundation
import SwiftData

class GameViewModel {
    
    // MARK: - Models & Properties
    var player: Character
    var enemy: Character
    var slots: [SlotItem]
    
    var currentStage: Int = 1
    var availableRerolls: Int = 3
    
    private var modelContext: ModelContext?
    private var pendingAtkBonus: Int = 0
    private var pendingHpBonus: Int = 0
    
    // MARK: - State Management
    var state: GameState = .idle {
        didSet { onStateChanged?(state) }
    }
    
    // MARK: - View-Ready Properties (UI Binding)
    var playerAtkText: String { "⚔️ ATK: \(player.baseAttack)" }
    var playerHpText: String { "❤️ HP: \(player.hp)" }
    var enemyHpText: String { "HP: \(enemy.hp) ❤️" }
    var enemyElementText: String { "Weak: \(enemy.element?.emoji ?? "❓")" }
    var stageText: String { "STAGE \(currentStage)" }
    var rewardAtkText: String { "PILIH: +\(pendingAtkBonus) ATK" }
    var rewardHpText: String { "PILIH: +\(pendingHpBonus) HP" }
    
    struct SlotPresentation {
        let emoji: String
        let isMaxed: Bool
        let buttonText: String
    }
    
    var slotsPresentation: [SlotPresentation] {
        return slots.map { slot in
            SlotPresentation(
                emoji: slot.element.emoji,
                isMaxed: slot.hasRerolled,
                buttonText: slot.hasRerolled ? "MAX" : "REROLL"
            )
        }
    }
    
    // MARK: - Callbacks / Closures
    var onStateChanged: ((GameState) -> Void)?
    var onSlotsUpdated: (([Int]) -> Void)?
    var onStatsUpdated: (() -> Void)?
    var onMessage: ((String) -> Void)?
    var onRewardReady: (() -> Void)?
    var onPlayerAttackVisual: (() -> Void)?
    var onPlayerDefeatVisual: (() -> Void)?
    
    // MARK: - Initialization
    init() {
        self.player = Character(hp: 100, maxHp: 100, baseAttack: 10)
        self.enemy = Character(hp: 50, maxHp: 50, baseAttack: 5, element: .api)
        self.slots = [
            SlotItem(element: .air),
            SlotItem(element: .api),
            SlotItem(element: .tanah)
        ]
        
        setupSwiftData()
        loadProgress()
    }
    
    // MARK: - User Intents (Actions from View)
    
    func intentSpinAll() {
        guard state == .idle else { return }
        
        state = .rolling // Prevent player from interacting while spinning
        
        for i in 0..<slots.count {
            slots[i].element = Element.allCases.randomElement() ?? .api
            slots[i].hasRerolled = false // Reset reroll limits for the new turn
        }
        
        // Trigger animation for all slots
        onSlotsUpdated?([0, 1, 2])
        
        // Wait for visual animation to finish before allowing actions
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.state = .playerTurn
        }
    }
    
    func intentRerollSlot(at index: Int) {
        guard state == .playerTurn, !slots[index].hasRerolled else { return }
        
        slots[index].element = Element.allCases.randomElement() ?? .api
        slots[index].hasRerolled = true // Mark slot as rerolled
        
        // Trigger animation only for the specific slot
        onSlotsUpdated?([index])
    }
    
    func intentAttack() {
        guard state == .playerTurn else { return }
        state = .attacking
        
        // Trigger visual attack animation
        onPlayerAttackVisual?()
        
        // Delay damage calculation to sync with the physical hit animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.resolvePlayerAttack()
        }
    }
    
    func intentSelectReward(increaseATK: Bool) {
        guard state == .rewardSelection else { return }
        
        // 1. Apply guaranteed base rewards
        player.maxHp += 10
        player.baseAttack += 2
        
        // 2. Apply Gacha bonus based on player's choice
        if increaseATK {
            player.baseAttack += pendingAtkBonus
            onMessage?("Stage Clear! Bonus: +\(pendingAtkBonus) ATK!")
        } else {
            player.maxHp += pendingHpBonus
            onMessage?("Stage Clear! Bonus: +\(pendingHpBonus) HP!")
        }
        
        // 3. Fully heal the player and proceed
        player.hp = player.maxHp
        pendingAtkBonus = 0
        pendingHpBonus = 0
        
        nextStage()
    }
    
    // MARK: - Internal Game Logic
    
    private func resolvePlayerAttack() {
        let playerElements = slots.map { $0.element }
        guard let enemyElement = enemy.element else { return }
        
        let damage = DamageCalculator.calculateDamage(
            playerElements: playerElements,
            enemyElement: enemyElement,
            baseAttack: player.baseAttack
        )
        
        enemy.takeDamage(damage)
        onStatsUpdated?()
        onMessage?("Player dealt \(damage) damage!")
        
        if enemy.isDead {
            prepareRewardSelection()
        } else {
            enemyTurn()
        }
    }
    
    private func enemyTurn() {
        state = .enemyTurn
        
        player.takeDamage(enemy.baseAttack)
        onStatsUpdated?()
        onMessage?("Enemy dealt \(enemy.baseAttack) damage!")
        
        if player.isDead {
            state = .gameOver
            onMessage?("GAME OVER! Restarting...")
            onPlayerDefeatVisual?()
            clearProgress()
            
            // Restart game after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
                self?.resetGame()
            }
        } else {
            state = .idle
            saveProgress()
        }
    }
    
    private func prepareRewardSelection() {
        // Calculate 1-3% bonus based on future stats
        let futureAtk = player.baseAttack + 2
        let futureMaxHp = player.maxHp + 10
        
        let percentAtk = Double.random(in: 0.01...0.03)
        let percentHp = Double.random(in: 0.01...0.03)
        
        pendingAtkBonus = max(1, Int(Double(futureAtk) * percentAtk))
        pendingHpBonus = max(1, Int(Double(futureMaxHp) * percentHp))
        
        state = .rewardSelection
        onRewardReady?()
    }
    
    private func nextStage() {
        currentStage += 1
        
        enemy = Character(
            hp: 50 + (currentStage * 10),
            maxHp: 50 + (currentStage * 10),
            baseAttack: 5 + currentStage,
            element: Element.allCases.randomElement() ?? .api
        )
        
        saveProgress()
        onStatsUpdated?()
        state = .idle
    }
    
    private func resetGame() {
        currentStage = 0
        player = Character(hp: 100, maxHp: 100, baseAttack: 10)
        nextStage()
    }
    
    // MARK: - Data Persistence (SwiftData)
    
    private func setupSwiftData() {
        do {
            let container = try ModelContainer(for: GameSaveData.self)
            modelContext = ModelContext(container)
        } catch {
            print("Failed to initialize SwiftData: \(error)")
        }
    }
    
    private func saveProgress() {
        guard let context = modelContext else { return }
        clearProgress() // Keep only the latest save
        
        let newSave = GameSaveData(
            currentStage: currentStage,
            playerHP: player.hp,
            playerMaxHP: player.maxHp,
            playerATK: player.baseAttack
        )
        
        context.insert(newSave)
        try? context.save()
    }
    
    private func loadProgress() {
        guard let context = modelContext else { return }
        let descriptor = FetchDescriptor<GameSaveData>()
        
        if let savedData = (try? context.fetch(descriptor))?.first {
            currentStage = savedData.currentStage
            player = Character(
                hp: savedData.playerHP,
                maxHp: savedData.playerMaxHP,
                baseAttack: savedData.playerATK
            )
            enemy = Character(
                hp: 50 + (currentStage * 10),
                maxHp: 50 + (currentStage * 10),
                baseAttack: 5 + currentStage,
                element: Element.allCases.randomElement() ?? .api
            )
        }
    }
    
    func clearProgress() {
        guard let context = modelContext else { return }
        try? context.delete(model: GameSaveData.self)
        try? context.save()
    }
}
