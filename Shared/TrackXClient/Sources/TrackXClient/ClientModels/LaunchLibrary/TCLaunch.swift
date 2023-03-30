import Foundation

// MARK: - TCLaunch

public struct TCLaunch: Codable {

    public let id: UUID
    public let url: String
    public let slug: String
    public let name: String?
    public let status: TCLaunchStatus
    public let lastUpdated: String?
    public let net: String?
    public let windowEnd: String?
    public let probability: Int?
    public let holdreason: String?
    public let failreason: String?
    public let hashtag: String?
    public let launchServiceProvider: TCAgency
    public let rocket: TCRocket
    public let mission: TCMission
    public let pad: TCLaunchpad
    public let webcastLive: Bool?
    public let image: String
    public let infographic: String?
    public let program: [TCProgram]
    public let orbitalLaunchAttemptCount: Int?
    public let locationLaunchAttemptCount: Int?
    public let padLaunchAttemptCount: Int?
    public let agencyLaunchAttemptCount: Int?
    public let orbitalLaunchAttemptCountYear: Int?
    public let locationLaunchAttemptCountYear: Int?
    public let padLaunchAttemptCountYear: Int?
    public let agencyLaunchAttemptCountYear: Int?

}
