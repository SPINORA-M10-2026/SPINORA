//
//  GameLayoutViewModel.swift
//  Spinora
//
//  Created by Stanley Young on 15/05/26.
//

import Foundation
import Combine

@MainActor
final class GameLayoutViewModel: ObservableObject {
    @Published var layoutData: BattleLayoutData = .preview
    @Published var overlay: GameOverlayType? = nil
    @Published var confirmAction: ConfirmAction? = nil

    func showWaveCleared() {
        overlay = .waveCleared
    }

    func showPause() {
        overlay = .pause
    }

    func showRestartWaveConfirmation() {
        confirmAction = .restartWave
        overlay = .confirmation
    }

    func showResetGameConfirmation() {
        confirmAction = .resetGame
        overlay = .confirmation
    }

    func closeOverlay() {
        overlay = nil
        confirmAction = nil
    }

    func backToPause() {
        overlay = .pause
        confirmAction = nil
    }

    func selectReward(_ reward: RewardChoice) {
        print("Selected reward:", reward.rawValue)
        closeOverlay()
    }

    func confirmCurrentAction() {
        switch confirmAction {
        case .restartWave:
            print("Restart wave confirmed")
        case .resetGame:
            print("Reset game confirmed")
        case .none:
            break
        }

        closeOverlay()
    }

    func attack() {
        print("Attack tapped")
    }

    func openInventory() {
        print("Inventory tapped")
    }
}
