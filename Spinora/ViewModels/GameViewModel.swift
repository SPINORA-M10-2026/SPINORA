//
//  GameViewModel.swift
//  SPINORA
//
//  Created by oky faishal on 12/05/26.
//

import Foundation
import SwiftData

class GameViewModel {
    
    var player: Character
    var enemy: Character
    var slots: [SlotItem]
    
    var currentStage: Int = 1
    var availableRerolls: Int = 3
    
    private var modelContext: ModelContext?
    
    private var pendingAtkBonus: Int = 0
    private var pendingHpBonus: Int = 0
    
    var state: GameState = .idle {
        didSet { onStateChanged?(state) }
    }
    
    // setup stats player
    var playerAtkText: String { "⚔️ ATK: \(player.baseAttack)" }
    var playerHpText: String { "❤️ HP: \(player.hp)" }
    
    // setup stats enemy
    var enemyHpText: String { "HP: \(enemy.hp) ❤️" }
    var enemyElementText: String { "Weak: \(enemy.element?.emoji ?? "❓")" }
    
    // setup stage
    var stageText: String { "STAGE \(currentStage)" }
    
    // setup reward gacha
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
    
    // UI Callbacks
    var onStateChanged: ((GameState) -> Void)?
    var onSlotsUpdated: (() -> Void)?
    var onStatsUpdated: (() -> Void)?
    var onMessage: ((String) -> Void)?
    var onRewardReady: (() -> Void)?
    
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
    
    private func setupSwiftData() {
        do {
            // Membuat wadah penyimpanan khusus untuk GameSaveData
            let container = try ModelContainer(for: GameSaveData.self)
            modelContext = ModelContext(container)
        } catch {
            print("Error inisialisasi SwiftData: \(error)")
        }
    }
    
    func intentSpinAll() {
        guard state == .idle else { return }
        for i in 0..<slots.count {
            slots[i].element = Element.allCases.randomElement()!
            slots[i].hasRerolled = false // Reset jatah reroll di setiap putaran baru
        }
        state = .playerTurn
        onSlotsUpdated?()
    }
    
    func intentRerollSlot(at index: Int) {
        guard state == .playerTurn else { return }
        
        // Cek apakah slot ini sudah pernah di-reroll? Jika sudah, hentikan fungsi.
        guard !slots[index].hasRerolled else { return }
        
        slots[index].element = Element.allCases.randomElement()!
        slots[index].hasRerolled = true // Tandai bahwa jatah reroll sudah terpakai
        
        onSlotsUpdated?()
    }
    
    func intentAttack() {
        guard state == .playerTurn else { return }
        
        state = .attacking
        
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
            // Kalkulasi gacha 1-3% dari status masa depan (setelah ditambah reward pasti)
            let percentAtk = Double(Int.random(in: 1...3)) / 100.0
            let percentHp = Double(Int.random(in: 1...3)) / 100.0
            
            let futureAtk = player.baseAttack + 2 // Asumsi base reward ATK = 2
            let futureMaxHp = player.maxHp + 10   // Asumsi base reward HP = 10
            
            pendingAtkBonus = max(1, Int(Double(futureAtk) * percentAtk))
            pendingHpBonus = max(1, Int(Double(futureMaxHp) * percentHp))
            
            state = .rewardSelection
            onRewardReady?()
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
            
            // Hapus data save karena pemain mati
            clearProgress()
            
            // Restart game ke kondisi awal (Stage 1) setelah 2 detik
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.currentStage = 0 // Set ke 0 agar nextStage() mengubahnya jadi 1
                self.player = Character(hp: 100, maxHp: 100, baseAttack: 10) // RESET PLAYER DI SINI
                self.nextStage()
            }
        } else {
            state = .idle
            saveProgress() // Simpan HP yang sudah berkurang
        }
    }
    
    func intentSelectReward(increaseATK: Bool) {
        guard state == .rewardSelection else { return }
        
        // 1. Berikan Reward Pasti
        player.maxHp += 10
        player.baseAttack += 2
        
        // 2. Berikan Reward Gacha sesuai pilihan
        if increaseATK {
            player.baseAttack += pendingAtkBonus
            onMessage?("Stage Clear! Bonus Gacha: +\(pendingAtkBonus) ATK!")
        } else {
            player.maxHp += pendingHpBonus
            onMessage?("Stage Clear! Bonus Gacha: +\(pendingHpBonus) HP!")
        }
        
        // 3. Heal dan Lanjut
        player.hp = player.maxHp
        pendingAtkBonus = 0
        pendingHpBonus = 0
        
        nextStage()
    }
    
    private func nextStage() {
        currentStage += 1
        
        // HANYA buat musuh baru, JANGAN buat player baru
        enemy = Character(
            hp: 50 + (currentStage * 10),
            maxHp: 50 + (currentStage * 10),
            baseAttack: 5 + currentStage,
            element: Element.allCases.randomElement()!
        )
        
        // Simpan progress SEGERA setelah masuk stage baru
        saveProgress()
        
        // Beritahu View untuk update tulisan di layar
        onStatsUpdated?()
        state = .idle
    }
    
    // MARK: - Data Persistence (SwiftData)
        
    private func saveProgress() {
        guard let context = modelContext else { return }
        
        // Hapus data lama agar kita hanya punya 1 save data aktif
        clearProgress()
        
        // Buat objek data baru
        let newSave = GameSaveData(
            currentStage: currentStage,
            playerHP: player.hp,
            playerMaxHP: player.maxHp,
            playerATK: player.baseAttack
        )
        
        // Masukkan ke database dan simpan
        context.insert(newSave)
        do {
            try context.save()
            print("Data berhasil disimpan via SwiftData! Stage: \(currentStage)")
        } catch {
            print("Gagal menyimpan data: \(error)")
        }
    }
        
    private func loadProgress() {
        guard let context = modelContext else { return }
        
        let descriptor = FetchDescriptor<GameSaveData>()
        
        do {
            let saves = try context.fetch(descriptor)
            
            if let savedData = saves.first {
                self.currentStage = savedData.currentStage
                
                // PERBAIKAN: Gunakan playerHP dari database untuk darah saat ini
                self.player = Character(
                    hp: savedData.playerHP,
                    maxHp: savedData.playerMaxHP,
                    baseAttack: savedData.playerATK
                )
                
                // Buat ulang musuh sesuai stage terakhir
                self.enemy = Character(
                    hp: 50 + (currentStage * 10),
                    maxHp: 50 + (currentStage * 10),
                    baseAttack: 5 + currentStage,
                    element: Element.allCases.randomElement()!
                )
                print("Data berhasil dimuat! Lanjut ke Stage \(currentStage) dengan HP: \(player.hp)")
            }
        } catch {
            print("Gagal memuat data: \(error)")
        }
    }
    
    func clearProgress() {
        guard let context = modelContext else { return }
        
        do {
            // Hapus semua data GameSaveData
            try context.delete(model: GameSaveData.self)
            try context.save()
        } catch {
            print("Gagal menghapus data: \(error)")
        }
    }
}
