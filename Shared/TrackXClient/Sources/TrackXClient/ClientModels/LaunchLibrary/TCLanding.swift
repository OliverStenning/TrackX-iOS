import Foundation

// MARK: - TCLanding

// LaunchLibrary v2.2.0 Schema Name: Landing

struct TCLanding: Codable {

    let id: Int
    let attempt: Bool?
    let success: Bool?
    let description: String?
    let location: TCLandingLocation?
    let type: TCLandingType?

}
