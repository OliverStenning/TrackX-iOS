import Foundation

// MARK: - Location

public struct Location: Hashable {

    // MARK: Lifecycle

    init(from location: TCLocation) {
        id = location.id
        url = location.url
        name = location.name
        countryCode = location.countryCode
        mapImage = location.mapImage
        totalLaunchCount = location.totalLaunchCount
        totalLandingCount = location.totalLandingCount
    }

    // MARK: Public

    public let id: Int
    public let url: String
    public let name: String?
    public let countryCode: String?
    public let mapImage: String?
    public let totalLaunchCount: Int?
    public let totalLandingCount: Int?

}
