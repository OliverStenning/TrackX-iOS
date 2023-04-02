import Foundation

// MARK: - TCAgency

// LaunchLibrary v2.2.0 Schema Name: AgencySerializerDetailedCommon

struct TCAgency: Codable {

    let id: Int
    let url: String
    let name: String
    let type: String?
    let countryCode: String?
    let abbrev: String?
    let description: String?
    let administrator: String?
    let foundingYear: String?
    let launchers: String?
    let spacecraft: String?
    let launchLibraryUrl: String?
    let totalLaunchCount: Int?
    let consecutiveSuccessfulLaunches: Int?
    let successfulLaunches: Int?
    let failedLaunches: Int?
    let pendingLaunches: Int?
    let consecutiveSuccessfulLandings: Int?
    let successfulLandings: Int?
    let failedLandings: Int?
    let attemptedLandings: Int?
    let infoUrl: String?
    let wikiUrl: String?
    let logoUrl: String?
    let imageUrl: String?
    let nationUrl: String?

}
