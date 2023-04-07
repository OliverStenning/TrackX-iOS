import Foundation

// MARK: - TCLaunchpad

// LaunchLibrary v2.2.0 Schema Name: Pad

struct TCLaunchpad: Codable {

    let id: Int
    let url: String
    let agencyId: Int?
    let name: String?
    let infoUrl: String?
    let wikiUrl: String?
    let mapUrl: String?
    let latitude: String?
    let longitude: String?
    let location: TCLocation
    let mapImage: String?
    let totalLaunchCount: Int?
    let orbitalLaunchAttemptCount: Int?

}
