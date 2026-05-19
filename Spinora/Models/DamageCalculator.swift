//
//  DamageCalculator.swift
//  Spinora
//
//  Created by oky faishal on 15/05/26.
//

import Foundation

struct DamageCalculator {
    
    /// Menghitung total damage berdasarkan elemen di slot pemain, elemen musuh, dan base attack
    static func calculateDamage(playerElements: [Element], enemyElement: Element, baseAttack: Int) -> Int {
        var totalElementMultiplier: Double = 0.0
        var strongElementCount = 0
        
        // 1. Hitung total multiplier dasar dari 3 elemen yang didapat pemain
        for element in playerElements {
            let multiplier = element.damageMultiplier(against: enemyElement)
            totalElementMultiplier += multiplier
            
            // Catat seberapa banyak elemen yang "Super Effective" untuk Combo
            if multiplier == 2.0 {
                strongElementCount += 1
            }
        }
        
        // 2. Kalkulasi Combo Multiplier (Sesuai aturan: 1 kuat = x1, 2 kuat = x2, 3 kuat = x4)
        var comboMultiplier: Double = 1.0
        if strongElementCount == 2 {
            comboMultiplier = 2.0
        } else if strongElementCount == 3 {
            comboMultiplier = 4.0
        }
        
        // 3. Kalkulasi Final
        // Tanpa combo → base damage saja. Combo memberi multiplier.
        let finalDamage = Double(baseAttack) * comboMultiplier
        
        return Int(finalDamage)
    }
}
