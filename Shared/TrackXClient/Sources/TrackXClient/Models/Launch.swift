import Foundation
import Utilities

public struct Launch: Hashable {

    // MARK: Lifecycle

    init(from launch: TCLaunch) {
//        id = launch.id
        url = launch.url
        slug = launch.slug
        name = launch.name?.replacingOccurrences(of: " | ", with: "\n")
        status = LaunchStatus(from: launch.status)
        lastUpdated = launch.lastUpdated?.convertToDate()
        net = launch.net?.convertToDate()
        windowEnd = launch.windowEnd?.convertToDate()
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

//    public let id: UUID
    public let url: String
    public let slug: String
    public let name: String?
    public let status: LaunchStatus
    public let lastUpdated: Date?
    public let net: Date?
    public let windowEnd: Date?
    public let probability: Int?
    public let holdreason: String?
    public let failreason: String?
    public let rocket: Rocket
    public let mission: Mission
    public let launchpad: Launchpad
    public let webcastLive: Bool?
    public let image: String

}
