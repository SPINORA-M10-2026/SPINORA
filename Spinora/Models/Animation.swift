import Foundation
import SwiftData

@Model
final class AnimationConfig {
    @Attribute(.unique) var id: UUID
    var reelSpinDuration: Float
    var hitShakeDuration: Float
    var hitShakeIntensity: Float
    var damageTextDuration: Float
    var waveClearFlashDuration: Float
    var screenShakeEnabled: Bool

    @Relationship var gameSettings: GameSettings?

    init(
        id: UUID = UUID(),
        reelSpinDuration: Float = 0.8,
        hitShakeDuration: Float = 0.3,
        hitShakeIntensity: Float = 5.0,
        damageTextDuration: Float = 1.0,
        waveClearFlashDuration: Float = 0.5,
        screenShakeEnabled: Bool = true
    ) {
        self.id = id
        self.reelSpinDuration = reelSpinDuration
        self.hitShakeDuration = hitShakeDuration
        self.hitShakeIntensity = hitShakeIntensity
        self.damageTextDuration = damageTextDuration
        self.waveClearFlashDuration = waveClearFlashDuration
        self.screenShakeEnabled = screenShakeEnabled
    }
}
