import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Stage \(viewModel.stage)")
                .font(.headline)

            Text(viewModel.monster.name)
            Text("Monster HP: \(viewModel.monster.currentHP)/\(viewModel.monster.maxHP)")
            Text("Player HP: \(viewModel.playerHP)/\(viewModel.playerMaxHP)")
            Text(viewModel.battleMessage)
                .font(.caption)

            AttackButtonView(viewModel: viewModel)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
