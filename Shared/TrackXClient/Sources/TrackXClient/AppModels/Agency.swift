import Foundation

// MARK: - Agency

public struct Agency: Hashable {

    // MARK: Lifecycle

    init(from agency: TCAgency) {
        id = agency.id
        url = agency.url
        name = agency.name
        type = agency.type
        countryCode = agency.countryCode
        abbrev = agency.abbrev
        description = agency.description
        administrator = agency.administrator
        foundingYear = agency.foundingYear
        launchers = agency.launchers
        spacecraft = agency.spacecraft
        launchLibraryUrl = agency.launchLibraryUrl
        totalLaunchCount = agency.totalLaunchCount
        consecutiveSuccessfulLaunches = agency.consecutiveSuccessfulLaunches
        successfulLaunches = agency.successfulLaunches
        failedLaunches = agency.failedLaunches
        pendingLaunches = agency.pendingLaunches
        consecutiveSuccessfulLandings = agency.consecutiveSuccessfulLandings
        successfulLandings = agency.successfulLandings
        failedLandings = agency.failedLandings
        attemptedLandings = agency.attemptedLandings
        infoUrl = agency.infoUrl
        wikiUrl = agency.wikiUrl
        logoUrl = agency.logoUrl
        imageUrl = agency.imageUrl
        nationUrl = agency.nationUrl
    }

    // MARK: Public

    public let id: Int
    public let url: String
    public let name: String
    public let type: String?
    public let countryCode: String?
    public let abbrev: String?
    public let description: String?
    public let administrator: String?
    public let foundingYear: String?
    public let launchers: String?
    public let spacecraft: String?
    public let launchLibraryUrl: String?
    public let totalLaunchCount: Int?
    public let consecutiveSuccessfulLaunches: Int?
    public let successfulLaunches: Int?
    public let failedLaunches: Int?
    public let pendingLaunches: Int?
    public let consecutiveSuccessfulLandings: Int?
    public let successfulLandings: Int?
    public let failedLandings: Int?
    public let attemptedLandings: Int?
    public let infoUrl: String?
    public let wikiUrl: String?
    public let logoUrl: String?
    public let imageUrl: String?
    public let nationUrl: String?

}
