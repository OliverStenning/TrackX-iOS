import Foundation

// MARK: - TCLauncherConfig

// LaunchLibrary v2.2.0 Schema Name: LauncherConfigDetail

struct TCLauncherConfig: Codable {

    let id: Int
    let url: String
    let name: String
    let active: Bool?
    let reusable: Bool?
    let description: String?
    let family: String?
    let fullName: String?
    let manufacturer: TCAgency
    let program: [TCProgram]
    let variant: String?
    let alias: String?
    let minStage: Int?
    let maxStage: Int?
    let length: Double?
    let diameter: Double?
    let maidenFlight: String?
    let launchCost: String?
    let launchMass: Int?
    let leoCapacity: Int?
    let gtoCapacity: Int?
    let toThrust: Int?
    let apogee: Int?
    let vehicleRange: Int?
    let imageUrl: String?
    let infoUrl: String?
    let wikiUrl: String?
    let totalLaunchCount: Int?
    let consecutiveSuccessfulLaunches: Int?
    let successfulLaunches: Int?
    let failedLaunches: Int?
    let pendingLaunches: Int?

}
