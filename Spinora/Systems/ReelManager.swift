import Foundation

final class ReelManager {
    private let randomManager: RandomManager
    private(set) var remainingRolls: Int

    init(randomManager: RandomManager = .shared, rollsPerTurn: Int = GameBalance.startingRollsPerTurn) {
        self.randomManager = randomManager
        self.remainingRolls = rollsPerTurn
    }

    var canRoll: Bool {
        remainingRolls > 0
    }

    func roll() -> Element? {
        guard canRoll else { return nil }
        remainingRolls -= 1
        return randomManager.randomElement()
    }

    func resetRolls(to count: Int = GameBalance.startingRollsPerTurn) {
        remainingRolls = count
    }
}
