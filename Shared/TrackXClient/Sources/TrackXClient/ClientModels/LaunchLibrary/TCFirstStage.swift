import Foundation

// MARK: - TCFirstStage

// LaunchLibrary v2.2.0 Schema Name: FirstStage

struct TCFirstStage: Codable {

    let id: Int
    let type: String
    let reused: Bool?
    let launcherFlightNumber: Int?
    let launcher: TCLauncher
    let landing: TCLanding?
    let previousFlightDate: String?
    let turnAroundTimeDays: Int?
    let previousFlight: TCLaunchMini?

}
