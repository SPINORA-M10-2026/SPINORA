import UIKit

final class HapticPlayer {
    static let shared = HapticPlayer()

    private init() {}

    func triggerLightHaptic() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    func triggerHeavyHaptic() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
}
