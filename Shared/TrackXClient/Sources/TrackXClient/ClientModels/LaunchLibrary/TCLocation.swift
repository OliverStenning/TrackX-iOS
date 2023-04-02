import Foundation

// MARK: - TCLocation

// LaunchLibrary v2.2.0 Schema Name:

public struct TCLocation: Codable {

    public let id: Int
    public let url: String
    public let name: String?
    public let countryCode: String?
    public let mapImage: String?
    public let totalLaunchCount: Int?
    public let totalLandingCount: Int?

}
