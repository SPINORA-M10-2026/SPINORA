//
//  ReelState.swift
//  Spinora
//
//  Created by Stanley Young on 13/05/26.
//

import Foundation

struct ReelState {
    var symbols: [Element]
    var rolledThisTurn: [Bool]
    var isRolling: Bool

    init(
        symbols: [Element] = [.fire, .water, .earth],
        rolledThisTurn: [Bool] = [false, false, false],
        isRolling: Bool = false
    ) {
        self.symbols = symbols
        self.rolledThisTurn = rolledThisTurn
        self.isRolling = isRolling
    }

    var usedRollCount: Int {
        rolledThisTurn.filter { $0 }.count
    }

    var reelCount: Int {
        symbols.count
    }

    var mainElement: Element? {
        symbols.first
    }

    var sameSymbolCount: Int {
        guard let mainElement else {
            return 0
        }

        return symbols.filter { $0 == mainElement }.count
    }
}
