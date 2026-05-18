//
//  AppModelContainer.swift
//  Spinora
//
//  Created by Stanley Young on 18/05/26.
//

import Foundation
import SwiftData

enum AppModelContainer {
    static let shared: ModelContainer = {
        do {
            let schema = Schema([
                PlayerProfileModel.self,
                SavedRunModel.self,
                RunUpgradeModel.self,
                RunHistoryModel.self
            ])

            let configuration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false
            )

            return try ModelContainer(
                for: schema,
                configurations: [configuration]
            )
        } catch {
            fatalError("Failed to create SwiftData ModelContainer: \(error)")
        }
    }()
}
