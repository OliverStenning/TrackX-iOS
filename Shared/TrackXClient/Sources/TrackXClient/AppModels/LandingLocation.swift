import Foundation

// MARK: - LandingLocation

public struct LandingLocation: Hashable {

    // MARK: Lifecycle

    init(from landingLocation: TCLandingLocation) {
        id = landingLocation.id
        name = landingLocation.name
        abbrev = landingLocation.abbrev
        description = landingLocation.description
        location = landingLocation.location.map { Location(from: $0) }
        successfulLandings = landingLocation.successfulLandings
    }

    // MARK: Public

    public let id: Int
    public let name: String?
    public let abbrev: String?
    public let description: String?
    public let location: Location?
    public let successfulLandings: Int?

}
