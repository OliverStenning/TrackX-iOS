import Foundation

// MARK: - Launcher

public struct Launcher: Hashable {

    // MARK: Lifecycle

    init(from launcher: TCLauncher) {
        id = launcher.id
        url = launcher.url
        details = launcher.details
        flightProven = launcher.flightProven
        serialNumber = launcher.serialNumber
        status = launcher.status
        imageUrl = launcher.imageUrl
        successfulLandings = launcher.successfulLandings
        attemptedLandings = launcher.attemptedLandings
        flights = launcher.flights
        lastLaunchDate = launcher.lastLaunchDate?.convertToDate()
        firstLaunchDate = launcher.firstLaunchDate?.convertToDate()
    }

    // MARK: Public

    public let id: Int
    public let url: String
    public let details: String?
    public let flightProven: Bool?
    public let serialNumber: String?
    public let status: String?
    public let imageUrl: String?
    public let successfulLandings: Int?
    public let attemptedLandings: Int?
    public let flights: Int?
    public let lastLaunchDate: Date?
    public let firstLaunchDate: Date?

}
