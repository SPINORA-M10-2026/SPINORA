import Foundation

enum SavedRunMapper {
    static func makeModel(from viewModel: GameViewModel, runID: UUID = UUID()) -> SavedRunModel {
        SavedRunModel(
            runID: runID,
            stage: viewModel.stage,
            playerHP: viewModel.playerHP,
            playerMaxHP: viewModel.playerMaxHP,
            playerDamage: viewModel.playerDamage,
            coins: viewModel.coins,
            monsterName: viewModel.monster.name,
            monsterElementRawValue: viewModel.monster.element.rawValue,
            monsterHP: viewModel.monster.currentHP,
            monsterMaxHP: viewModel.monster.maxHP
        )
    }
}
