//
//  Player.swift
//  Spinora
//
//  Created by oky faishal on 15/05/26.
//

import Foundation

struct Character {
    var hp: Int
    var maxHp: Int
    var baseAttack: Int
    
    var element: Element?
    
    // hp
    mutating func takeDamage(_ amount: Int) {
        self.hp = max(0, self.hp - amount)
    }
    
    // max HP
//    mutating func heal(_ amount: Int) {
//        self.hp = min(self.maxHp, self.hp + amount)
//    }
    
    var isDead: Bool {
        return self.hp <= 0
    }
}
