//
//  ReelRollResult.swift
//  Spinora
//
//  Created by Stanley Young on 13/05/26.
//

import Foundation

struct ReelRollResult {
    let index: Int
    let symbol: Element
    let duration: TimeInterval

    init(index: Int, symbol: Element, duration: TimeInterval) {
        self.index = index
        self.symbol = symbol
        self.duration = duration
    }
}
