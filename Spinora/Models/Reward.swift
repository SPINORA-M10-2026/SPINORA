import Foundation
import SwiftData

@Model
final class RewardPick {
    @Attribute(.unique) var id: UUID
    var waveNumber: Int
    var chosenType: String
    var hpValue: Float
    var atkValue: Float
    var pickedAt: Date?

    @Relationship var savedRun: SavedRun?
    @Relationship var waveState: WaveState?

    init(
        id: UUID = UUID(),
        waveNumber: Int,
        chosenType: String = "",
        hpValue: Float = 0,
        atkValue: Float = 0
    ) {
        self.id = id
        self.waveNumber = waveNumber
        self.chosenType = chosenType
        self.hpValue = hpValue
        self.atkValue = atkValue
    }
}
