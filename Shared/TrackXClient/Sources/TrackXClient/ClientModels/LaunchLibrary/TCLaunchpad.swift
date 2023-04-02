import Foundation

// MARK: - TCLaunchpad

// LaunchLibrary v2.2.0 Schema Name: Pad

public struct TCLaunchpad: Codable {

    public let id: Int
    public let url: String
    public let agencyId: Int?
    public let name: String?
    public let infoUrl: String?
    public let wikiUrl: String?
    public let mapUrl: String?
    public let latitude: String?
    public let longitude: String?
    public let location: TCLocation
    public let mapImage: String?
    public let totalLaunchCount: Int?
    public let orbitalLaunchAttemptCount: Int?

}
