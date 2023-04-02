import Foundation

// MARK: - TCLaunch

// LaunchLibrary v2.2.0 Schema Name: LaunchDetailed

struct TCLaunch: Codable {

    let id: String
    let url: String
    let slug: String
    let flightClubUrl: String?
    let rSpacexApiId: String?
    let name: String
    let status: TCLaunchStatus
    let lastUpdated: String
    let updates: [TCUpdate]
    let net: String?
    let windowEnd: String?
    let windowStart: String?
    let probability: Int?
    let holdreason: String?
    let failreason: String
    let hashtag: String?
    let launchServiceProvider: TCAgency
    let rocket: TCRocket
    let mission: TCMission
    let pad: TCLaunchpad
    let infoURLs: [TCInfoUrl]
    let vidURLs: [TCVidUrl]
    let webcastLive: Bool
    let image: String
    let infographic: String?
    let program: [TCProgram]
    let orbitalLaunchAttemptCount: Int?
    let locationLaunchAttemptCount: Int?
    let padLaunchAttemptCount: Int?
    let agencyLaunchAttemptCount: Int?
    let orbitalLaunchAttemptCountYear: Int?
    let locationLaunchAttemptCountYear: Int?
    let padLaunchAttemptCountYear: Int?
    let agencyLaunchAttemptCountYear: Int?
    let missionPatches: [TCMissionPatch]

}
