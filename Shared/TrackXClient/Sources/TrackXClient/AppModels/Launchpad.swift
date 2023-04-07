import Foundation

// MARK: - Launchpad

public struct Launchpad: Hashable {

    // MARK: Lifecycle

    init(from launchpad: TCLaunchpad) {
        id = launchpad.id
        url = launchpad.url
        agencyId = launchpad.agencyId
        name = launchpad.name
        infoUrl = launchpad.infoUrl
        wikiUrl = launchpad.wikiUrl
        mapUrl = launchpad.mapUrl
        latitude = launchpad.latitude
        longitude = launchpad.longitude
        location = Location(from: launchpad.location)
        mapImage = launchpad.mapImage
        totalLaunchCount = launchpad.totalLaunchCount
        orbitalLaunchAttemptCount = launchpad.orbitalLaunchAttemptCount
    }

    // MARK: Public

    public let id: Int
    public let url: String
    public let agencyId: Int?
    public let name: String?
    public let infoUrl: String?
    public let wikiUrl: String?
    public let mapUrl: String?
    public let latitude: String?
    public let longitude: String?
    public let location: Location
    public let mapImage: String?
    public let totalLaunchCount: Int?
    public let orbitalLaunchAttemptCount: Int?

}
