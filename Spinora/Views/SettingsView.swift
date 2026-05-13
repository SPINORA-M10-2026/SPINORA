import SwiftUI

struct SettingsView: View {
    @State private var isSoundEnabled = true
    @State private var isHapticsEnabled = true

    var body: some View {
        Form {
            Toggle("Sound", isOn: $isSoundEnabled)
            Toggle("Haptics", isOn: $isHapticsEnabled)
        }
    }
}

#Preview {
    SettingsView()
}
