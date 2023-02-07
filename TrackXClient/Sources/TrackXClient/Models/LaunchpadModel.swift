import Foundation

public final class LaunchpadModel {
    
    let id: UUID
    let name: String
    let fullName: String
    let region: String
    let longitude: Double
    let latitude: Double
    
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
