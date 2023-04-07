import Foundation

// MARK: - FirstStage

public struct FirstStage: Hashable {

    // MARK: Lifecycle

    init(from firstStage: TCFirstStage) {
        id = firstStage.id
        type = firstStage.type
        reused = firstStage.reused
        launcherFlightNumber = firstStage.launcherFlightNumber
        launcher = Launcher(from: firstStage.launcher)
        landing = firstStage.landing.map { Landing(from: $0) }
        previousFlightDate = firstStage.previousFlightDate?.convertToDate()
        turnAroundTimeDays = firstStage.turnAroundTimeDays
        previousFlight = firstStage.previousFlight.map { LaunchMini(from: $0) }
    }

    // MARK: Public

    public let id: Int
    public let type: String
    public let reused: Bool?
    public let launcherFlightNumber: Int?
    public let launcher: Launcher
    public let landing: Landing?
    public let previousFlightDate: Date?
    public let turnAroundTimeDays: Int?
    public let previousFlight: LaunchMini?

}
