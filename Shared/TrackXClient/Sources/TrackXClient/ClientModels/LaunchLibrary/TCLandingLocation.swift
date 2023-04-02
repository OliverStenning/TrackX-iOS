import Foundation

// MARK: - TCLandingLocation

// LaunchLibrary v2.2.0 Schema Name: LandingLocation

struct TCLandingLocation: Codable {

    let id: Int
    let name: String?
    let abbrev: String?
    let description: String?
    let location: TCLocation?
    let successfulLandings: Int?

}
