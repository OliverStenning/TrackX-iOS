import Foundation

public final class LaunchModel {
    
    let id: UUID
    let name: String
    let dateUtc: String
    let upcoming: Bool
    let success: Bool?
    let description: String?
    let rocket: RocketModel
    let cores: String
    let payloads: String
    let launchpad: LaunchpadModel
    
    init(
        id: UUID,
        name: String,
        dateUtc: String,
        upcoming: Bool,
        success: Bool?,
        description: String?,
        rocket: RocketModel,
        cores: String,
        payloads: String,
        launchpad: LaunchpadModel
    ) {
        self.id = id
        self.name = name
        self.dateUtc = dateUtc
        self.upcoming = upcoming
        self.success = success
        self.description = description
        self.rocket = rocket
        self.cores = cores
        self.payloads = payloads
        self.launchpad = launchpad
    }
    
    init(from launch: LaunchV1) {
        self.id = launch.id
        self.name = launch.name
        self.dateUtc = launch.dateUtc
        self.upcoming = launch.upcoming
        self.success = launch.success
        self.description = launch.description
        self.rocket = RocketModel(from: launch.rocket)
        self.cores = launch.cores
        self.payloads = launch.payloads
        self.launchpad = LaunchpadModel(from: launch.launchpad)
    }

}
