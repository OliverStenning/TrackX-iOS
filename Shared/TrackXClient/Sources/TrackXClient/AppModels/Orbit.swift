import Foundation

// MARK: - Orbit

public struct Orbit: Hashable {

    // MARK: Lifecycle

    init(from orbit: TCOrbit) {
        id = orbit.id
        name = orbit.name
        abbrev = orbit.abbrev
    }

    // MARK: Public

    public let id: Int
    public let name: String
    public let abbrev: String

}
