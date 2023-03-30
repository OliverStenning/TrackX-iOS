import Foundation

// MARK: - TCMission

public struct TCMission: Hashable, Codable {

    public let id: Int
    public let name: String
    public let description: String?
    public let launchDesignator: String?
    public let type: String
    public let orbit: TCOrbit

}
