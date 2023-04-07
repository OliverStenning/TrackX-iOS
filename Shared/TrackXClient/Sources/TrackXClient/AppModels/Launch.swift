import Foundation
import Utilities

// MARK: - Launch

public struct Launch: Hashable {

    // MARK: Lifecycle

    init(from launch: TCLaunch) {
        url = launch.url
        slug = launch.slug
        name = launch.name
        status = LaunchStatus(from: launch.status)
        lastUpdated = launch.lastUpdated.convertToDate()
        updates = launch.updates.map { Update(from: $0) }
        net = launch.net?.convertToDate()
        windowEnd = launch.windowEnd?.convertToDate()
        windowStart = launch.windowStart?.convertToDate()
        probability = launch.probability
        holdreason = launch.holdreason
        failreason = launch.failreason
        launchServiceProvider = Agency(from: launch.launchServiceProvider)
        rocket = Rocket(from: launch.rocket)
        mission = Mission(from: launch.mission)
        pad = Launchpad(from: launch.pad)
        webcastLive = launch.webcastLive
        image = launch.image
        program = launch.program.map { Program(from: $0) }
        orbitalLaunchAttemptCount = launch.orbitalLaunchAttemptCount
        locationLaunchAttemptCount = launch.locationLaunchAttemptCount
        padLaunchAttemptCount = launch.padLaunchAttemptCount
        agencyLaunchAttemptCount = launch.agencyLaunchAttemptCount
        orbitalLaunchAttemptCountYear = launch.orbitalLaunchAttemptCountYear
        locationLaunchAttemptCountYear = launch.locationLaunchAttemptCountYear
        padLaunchAttemptCountYear = launch.padLaunchAttemptCountYear
        agencyLaunchAttemptCountYear = launch.agencyLaunchAttemptCountYear
    }

    // MARK: Public

    public let url: String
    public let slug: String
    public let name: String
    public let status: LaunchStatus
    public let lastUpdated: Date?
    public let updates: [Update]
    public let net: Date?
    public let windowEnd: Date?
    public let windowStart: Date?
    public let probability: Int?
    public let holdreason: String?
    public let failreason: String
    public let launchServiceProvider: Agency
    public let rocket: Rocket
    public let mission: Mission
    public let pad: Launchpad
    public let webcastLive: Bool
    public let image: String
    public let program: [Program]
    public let orbitalLaunchAttemptCount: Int?
    public let locationLaunchAttemptCount: Int?
    public let padLaunchAttemptCount: Int?
    public let agencyLaunchAttemptCount: Int?
    public let orbitalLaunchAttemptCountYear: Int?
    public let locationLaunchAttemptCountYear: Int?
    public let padLaunchAttemptCountYear: Int?
    public let agencyLaunchAttemptCountYear: Int?

//    init(from launch: TCLaunch) {
    ////        id = launch.id
//        url = launch.url
//        slug = launch.slug
//        name = launch.name.replacingOccurrences(of: " | ", with: "\n")
//        status = LaunchStatus(from: launch.status)
//        lastUpdated = launch.lastUpdated.convertToDate()
//        net = launch.net?.convertToDate()
//        windowEnd = launch.windowEnd?.convertToDate()
//        probability = launch.probability
//        holdreason = launch.holdreason
//        failreason = launch.failreason
//        rocket = Rocket(from: launch.rocket)
//        mission = Mission(from: launch.mission)
//        launchpad = Launchpad(from: launch.pad)
//        webcastLive = launch.webcastLive
//        image = launch.image
//    }

}
