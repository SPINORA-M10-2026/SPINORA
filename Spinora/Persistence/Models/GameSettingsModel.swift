import Foundation
import SwiftData

@Model
final class GameSettingsModel {
    @Attribute(.unique) var id: String
    var isSoundEnabled: Bool
    var isHapticsEnabled: Bool

    init(id: String = "default", isSoundEnabled: Bool = true, isHapticsEnabled: Bool = true) {
        self.id = id
        self.isSoundEnabled = isSoundEnabled
        self.isHapticsEnabled = isHapticsEnabled
    }
}
