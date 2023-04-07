import Foundation

// MARK: - Landing

public struct Landing: Hashable {

    // MARK: Lifecycle

    init(from landing: TCLanding) {
        id = landing.id
        attempt = landing.attempt
        success = landing.success
        description = landing.description
        location = landing.location.map { LandingLocation(from: $0) }
        type = landing.type.map { LandingType(from: $0) }
    }

    // MARK: Public

    public let id: Int
    public let attempt: Bool?
    public let success: Bool?
    public let description: String?
    public let location: LandingLocation?
    public let type: LandingType?

}
