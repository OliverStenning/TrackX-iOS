import Foundation

// MARK: - TCLocation

public struct TCLocation: Hashable, Codable {

    public let id: Int
    public let url: String
    public let name: String?
    public let countryCode: String?
    public let mapImage: String?
    public let totalLaunchCount: Int?
    public let totalLandingCount: Int?

}
