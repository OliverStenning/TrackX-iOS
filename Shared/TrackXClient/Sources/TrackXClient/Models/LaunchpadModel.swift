import Foundation

public struct LaunchpadModel: Hashable {
    public let id: UUID
    public let name: String
    public let fullName: String
    public let region: String
    public let longitude: Double
    public let latitude: Double

    init(
        id: UUID,
        name: String,
        fullName: String,
        region: String,
        longitude: Double,
        latitude: Double
    ) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.region = region
        self.longitude = longitude
        self.latitude = latitude
    }

    init(from launchpad: LaunchpadV1) {
        id = launchpad.id
        name = launchpad.name
        fullName = launchpad.fullName
        region = launchpad.region
        longitude = launchpad.longitude
        latitude = launchpad.latitude
    }
}
