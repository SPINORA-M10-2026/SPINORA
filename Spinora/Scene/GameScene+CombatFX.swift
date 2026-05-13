import SpriteKit

extension GameScene {
    func showDamageText(_ amount: Int, at point: CGPoint) {
        // TODO: Person 1 owns damage text styling and animation.
    }

    func playHitFeedback() {
        SoundPlayer.shared.playHitSound()
        HapticPlayer.shared.triggerLightHaptic()
    }

    func playStageClearFeedback() {
        SoundPlayer.shared.playStageClearSound()
        HapticPlayer.shared.triggerHeavyHaptic()
    }
}
