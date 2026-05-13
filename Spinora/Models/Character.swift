//
//  Character.swift
//  SPINORA
//
//  Created by oky faishal on 12/05/26.
//

import Foundation

struct Character {
    var hp: Int
    var maxHp: Int
    var baseAttack: Int
    
    // Status elemen untuk musuh (Pemain tidak memiliki elemen statis karena dari Slot)
    var element: Element?
    
    // Fungsi bantuan untuk logika darah
    mutating func takeDamage(_ amount: Int) {
        self.hp = max(0, self.hp - amount) // HP tidak bisa di bawah 0
    }
    
    mutating func heal(_ amount: Int) {
        self.hp = min(self.maxHp, self.hp + amount) // HP tidak bisa melebihi Max HP
    }
    
    var isDead: Bool {
        return self.hp <= 0
    }
}
