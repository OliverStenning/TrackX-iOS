import Foundation

// MARK: - TCMission

// LaunchLibrary v2.2.0 Schema Name: Mission

public struct TCMission: Codable {

    public let id: Int
    public let name: String
    public let description: String?
    public let launchDesignator: String?
    public let type: String
    public let orbit: TCOrbit

}
