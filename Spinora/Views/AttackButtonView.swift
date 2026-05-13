import SwiftUI

struct AttackButtonView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        HStack {
            Button("Roll") {
                viewModel.rollElement()
            }

            Button("Attack") {
                viewModel.attack()
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    AttackButtonView(viewModel: GameViewModel())
}
