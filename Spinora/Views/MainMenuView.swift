import SwiftUI

struct MainMenuView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Spinora")
                .font(.largeTitle)
            Button("Start Run") {}
            Button("Run History") {}
            Button("Settings") {}
        }
        .buttonStyle(.bordered)
        .padding()
    }
}

#Preview {
    MainMenuView()
}
