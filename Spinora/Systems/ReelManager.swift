//
//  ReelManager.swift
//  Spinora
//
//  Created by Stanley Young on 13/05/26.
//

import Foundation
import CoreGraphics

final class ReelManager {
    private let randomManager: RandomManager

    init(randomManager: RandomManager = RandomManager()) {
        self.randomManager = randomManager
    }

    // MARK: - New Turn

    func makeInitialSymbols(count: Int = 3) -> [Element] {
        randomManager.randomElements(count: count)
    }

    func makeInitialRolledState(count: Int = 3) -> [Bool] {
        Array(repeating: false, count: count)
    }

    func makeNewTurnState(count: Int = 3) -> ReelState {
        ReelState(
            symbols: makeInitialSymbols(count: count),
            rolledThisTurn: makeInitialRolledState(count: count),
            isRolling: false
        )
    }

    // MARK: - Roll Validation

    func canRoll(
        index: Int,
        rolledThisTurn: [Bool],
        isRolling: Bool,
        isGameOver: Bool,
        showingUpgradeSheet: Bool
    ) -> Bool {
        guard index >= 0 else {
            return false
        }

        guard index < rolledThisTurn.count else {
            return false
        }

        guard !isRolling else {
            return false
        }

        guard !isGameOver else {
            return false
        }

        guard !showingUpgradeSheet else {
            return false
        }

        return rolledThisTurn[index] == false
    }

    // MARK: - Roll Result

    func createRollResult(
        index: Int,
        rolledThisTurn: [Bool],
        isRolling: Bool,
        isGameOver: Bool,
        showingUpgradeSheet: Bool
    ) -> ReelRollResult? {
        guard canRoll(
            index: index,
            rolledThisTurn: rolledThisTurn,
            isRolling: isRolling,
            isGameOver: isGameOver,
            showingUpgradeSheet: showingUpgradeSheet
        ) else {
            return nil
        }

        return ReelRollResult(
            index: index,
            symbol: randomManager.randomElement(),
            duration: spinDuration(for: index)
        )
    }

    func commitRoll(
        result: ReelRollResult,
        symbols: [Element],
        rolledThisTurn: [Bool]
    ) -> ReelState {
        var updatedSymbols = symbols
        var updatedRolledThisTurn = rolledThisTurn

        guard result.index >= 0 else {
            return ReelState(
                symbols: symbols,
                rolledThisTurn: rolledThisTurn,
                isRolling: false
            )
        }

        guard result.index < updatedSymbols.count else {
            return ReelState(
                symbols: symbols,
                rolledThisTurn: rolledThisTurn,
                isRolling: false
            )
        }

        guard result.index < updatedRolledThisTurn.count else {
            return ReelState(
                symbols: symbols,
                rolledThisTurn: rolledThisTurn,
                isRolling: false
            )
        }

        updatedSymbols[result.index] = result.symbol
        updatedRolledThisTurn[result.index] = true

        return ReelState(
            symbols: updatedSymbols,
            rolledThisTurn: updatedRolledThisTurn,
            isRolling: false
        )
    }

    // MARK: - Reel Info

    func usedRollCount(_ rolledThisTurn: [Bool]) -> Int {
        rolledThisTurn.filter { $0 }.count
    }

    func mainElement(from symbols: [Element]) -> Element? {
        symbols.first
    }

    func sameSymbolCount(from symbols: [Element]) -> Int {
        guard let mainElement = symbols.first else {
            return 0
        }

        return symbols.filter { $0 == mainElement }.count
    }

    // MARK: - Spin Timing

    func spinDuration(for index: Int) -> TimeInterval {
        switch index {
        case 0:
            return 0.65
        case 1:
            return 0.85
        case 2:
            return 1.05
        default:
            return 0.85
        }
    }

    // MARK: - Input Rule

    func shouldTriggerRoll(deltaX: CGFloat, deltaY: CGFloat) -> Bool {
        abs(deltaY) > 12 || abs(deltaX) < 40
    }
}
