import Foundation

// MARK: - Spacecraft

public struct Spacecraft: Hashable {

    // MARK: Lifecycle

    init(from spacecraft: TCSpacecraft) {
        id = spacecraft.id
        url = spacecraft.url
        name = spacecraft.name
        serialNumber = spacecraft.serialNumber
        description = spacecraft.description
    }

    // MARK: Public

    public let id: Int
    public let url: String
    public let name: String
    public let serialNumber: String?
    public let description: String

}
