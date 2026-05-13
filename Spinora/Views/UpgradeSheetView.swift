import SwiftUI

struct UpgradeSheetView: View {
    let options: [UpgradeOption]

    var body: some View {
        List(options) { option in
            VStack(alignment: .leading) {
                Text(option.title)
                Text("+\(option.value) \(option.kind.rawValue)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    UpgradeSheetView(options: UpgradeManager().generateUpgradeOptions())
}
