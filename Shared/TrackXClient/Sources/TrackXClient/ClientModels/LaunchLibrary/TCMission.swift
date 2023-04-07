import Foundation

// MARK: - TCMission

// LaunchLibrary v2.2.0 Schema Name: Mission

struct TCMission: Codable {

    let id: Int
    let name: String
    let description: String?
    let launchDesignator: String?
    let type: String
    let orbit: TCOrbit

}
