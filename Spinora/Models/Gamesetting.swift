import Foundation
import SwiftData

@Model
final class GameSettings {
    @Attribute(.unique) var id: UUID
    var sfxEnabled: Bool
    var hapticEnabled: Bool
    var sfxVolume: Float
    var bgmVolume: Float

    @Relationship var player: Player?
    @Relationship(deleteRule: .cascade) var sfxConfig: SFXConfig?
    @Relationship(deleteRule: .cascade) var animationConfig: AnimationConfig?

    init(
        id: UUID = UUID(),
        sfxEnabled: Bool = true,
        hapticEnabled: Bool = true,
        sfxVolume: Float = 0.8,
        bgmVolume: Float = 0.5
    ) {
        self.id = id
        self.sfxEnabled = sfxEnabled
        self.hapticEnabled = hapticEnabled
        self.sfxVolume = sfxVolume
        self.bgmVolume = bgmVolume
    }
}
