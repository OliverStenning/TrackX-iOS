import Foundation

public struct Launch: Hashable {

    // MARK: Lifecycle

    init(from launch: TCLaunch) {
        id = launch.id
        url = launch.url
        slug = launch.slug
        name = launch.name
        status = LaunchStatus(from: launch.status)
        lastUpdated = launch.lastUpdated
        net = launch.net
        windowEnd = launch.windowEnd
        probability = launch.probability
        holdreason = launch.holdreason
        failreason = launch.failreason
        rocket = Rocket(from: launch.rocket)
        mission = Mission(from: launch.mission)
        launchpad = Launchpad(from: launch.pad)
        webcastLive = launch.webcastLive
        image = launch.image
    }

    // MARK: Public

    public let id: UUID
    public let url: String
    public let slug: String
    public let name: String?
    public let status: LaunchStatus
    public let lastUpdated: String?
    public let net: String?
    public let windowEnd: String?
    public let probability: Int?
    public let holdreason: String?
    public let failreason: String?
    public let rocket: Rocket
    public let mission: Mission
    public let launchpad: Launchpad
    public let webcastLive: Bool?
    public let image: String

}
