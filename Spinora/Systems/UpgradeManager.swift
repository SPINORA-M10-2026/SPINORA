import Foundation

final class UpgradeManager {
    func generateUpgradeOptions() -> [UpgradeOption] {
        [
            UpgradeOption(title: "Sharpen Blade", kind: .damage, value: 3),
            UpgradeOption(title: "Fortify Heart", kind: .maxHP, value: 10),
            UpgradeOption(title: "Recover", kind: .heal, value: 15)
        ]
    }
}
