import Foundation

public struct LaunchModel: Hashable {
    
    public let id: UUID
    public let name: String
    public let dateUtc: String
    public let upcoming: Bool
    public let success: Bool?
    public let description: String?
    public let rocket: RocketModel
    public let cores: String
    public let payloads: String
    public let launchpad: LaunchpadModel
    
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
    
    public static func mock() -> LaunchModel {
        LaunchModel(
            id: UUID(),
            name: "Falcon 9 Block 5 | Starlink Group 5-5",
            dateUtc: "2023-03-24T15:43:10Z",
            upcoming: true,
            success: nil,
            description: "",
            rocket:
                .init(
                    id: UUID(),
                    name: "Falcon 9",
                    active: true,
                    stages: 2,
                    boosters: 1,
                    launchCost: 10,
                    successRate: 99,
                    height: 90,
                    diameter: 10,
                    mass: 100
                ),
            cores: "1",
            payloads: "",
            launchpad:
                .init(
                    id: UUID(),
                    name: "LC39A",
                    fullName: "Launch Complex 39A",
                    region: "Florida",
                    longitude: 100,
                    latitude: 100
                )
        )
    }

}
