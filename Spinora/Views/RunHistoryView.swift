import SwiftUI

struct RunHistoryView: View {
    let history: [RunHistoryModel]

    var body: some View {
        List(history) { item in
            VStack(alignment: .leading) {
                Text("Stage \(item.finalStage)")
                Text("\(item.result) - \(item.coinsEarned) coins")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    RunHistoryView(history: [])
}
