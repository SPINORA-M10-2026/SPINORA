//
//  SlotItem.swift
//  SPINORA
//
//  Created by oky faishal on 12/05/26.
//

import Foundation

struct SlotItem {
    var element: Element
    var hasRerolled: Bool = false
    var hasBeenRerolled: Bool = false
    
    // Memutar elemen secara acak
    mutating func randomize() {
        let allElements = Element.allCases
        self.element = allElements.randomElement() ?? .air
    }
    
    // Fungsi untuk menandai bahwa slot ini sudah dipakai jatah reroll-nya
    mutating func markAsRerolled() {
        self.hasBeenRerolled = true
    }
}
