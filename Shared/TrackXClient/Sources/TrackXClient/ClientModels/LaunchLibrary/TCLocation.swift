import Foundation

// MARK: - TCLocation

// LaunchLibrary v2.2.0 Schema Name:

struct TCLocation: Codable {

    let id: Int
    let url: String
    let name: String?
    let countryCode: String?
    let mapImage: String?
    let totalLaunchCount: Int?
    let totalLandingCount: Int?

}
