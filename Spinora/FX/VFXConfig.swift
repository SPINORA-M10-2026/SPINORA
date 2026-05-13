import CoreGraphics
import Foundation

struct VFXConfig {
    var damageTextDuration: TimeInterval = 0.8
    var hitFlashDuration: TimeInterval = 0.12
    var screenShakeOffset: CGFloat = 8

    static let standard = VFXConfig()
}
