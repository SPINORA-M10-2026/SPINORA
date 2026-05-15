import Foundation
import SwiftData

@Model
final class Roll {
    @Attribute(.unique) var id: UUID
    var reel1: String
    var reel2: String
    var reel3: String
    var isJackpot: Bool
    var spinCount: Int
//    var rerollsUsed: Int
//    var waveNumber: Int

    @Relationship var savedRun: SavedRun?
    @Relationship(deleteRule: .cascade) var jackpot: Jackpot?

    init(
        id: UUID = UUID(),
        reel1: String = "",
        reel2: String = "",
        reel3: String = "",
        isJackpot: Bool = false,
        spinCount: Int = 0,
//        rerollsUsed: Int = 0,
//        waveNumber: Int = 1
    ) {
        self.id = id
        self.reel1 = reel1
        self.reel2 = reel2
        self.reel3 = reel3
        self.isJackpot = isJackpot
        self.spinCount = spinCount
//        self.rerollsUsed = rerollsUsed
//        self.waveNumber = waveNumber
    }
}
