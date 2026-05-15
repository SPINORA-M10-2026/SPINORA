import Foundation
import SwiftData

@Model
final class SFXConfig {
    @Attribute(.unique) var id: UUID
    var attackSound: String
    var hitSound: String
    var jackpotSound: String
    var waveClearSound: String
    var defeatSound: String
    var reelSpinSound: String

    @Relationship var gameSettings: GameSettings?

    init(
        id: UUID = UUID(),
        attackSound: String = "attack_01",
        hitSound: String = "hit_01",
        jackpotSound: String = "jackpot_01",
        waveClearSound: String = "wave_clear_01",
        defeatSound: String = "defeat_01",
        reelSpinSound: String = "reel_spin_01"
    ) {
        self.id = id
        self.attackSound = attackSound
        self.hitSound = hitSound
        self.jackpotSound = jackpotSound
        self.waveClearSound = waveClearSound
        self.defeatSound = defeatSound
        self.reelSpinSound = reelSpinSound
    }
}
