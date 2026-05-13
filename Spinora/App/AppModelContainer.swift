import SwiftData

enum AppModelContainer {
    static func make() throws -> ModelContainer {
        let schema = Schema([
            SavedRunModel.self,
            RunHistoryModel.self,
            GameSettingsModel.self,
            PlayerProfileModel.self,
            UpgradeRecordModel.self,
            StageRecordModel.self,
            ReelStatsModel.self
        ])

        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        return try ModelContainer(for: schema, configurations: [configuration])
    }
}
