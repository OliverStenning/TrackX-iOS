import Foundation

// MARK: - TCLauncher

// LaunchLibrary v2.2.0 Schema Name: LauncherDetailed

struct TCLauncher: Codable {

    let id: Int
    let url: String
    let details: String?
    let flightProven: Bool?
    let serialNumber: String?
    let status: String?
    let imageUrl: String?
    let successfulLandings: Int?
    let attemptedLandings: Int?
    let flights: Int?
    let lastLaunchDate: String?
    let firstLaunchDate: String?

}
