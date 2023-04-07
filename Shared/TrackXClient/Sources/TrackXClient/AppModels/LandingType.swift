import Foundation

// MARK: - LandingType

public struct LandingType: Hashable {

    // MARK: Lifecycle

    init(from landingType: TCLandingType) {
        id = landingType.id
        name = landingType.name
        abbrev = landingType.abbrev
        description = landingType.description
    }

    // MARK: Public

    public let id: Int
    public let name: String?
    public let abbrev: String?
    public let description: String?

}
