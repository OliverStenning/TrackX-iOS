import Foundation

public final class LaunchpadModel {
    
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
        self.id = launchpad.id
        self.name = launchpad.name
        self.fullName = launchpad.fullName
        self.region = launchpad.region
        self.longitude = launchpad.longitude
        self.latitude = launchpad.latitude
    }
    
}
