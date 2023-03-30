import Foundation

// MARK: - Mission

public struct Mission: Hashable {

    // MARK: Lifecycle

    init(from mission: TCMission) {
        id = mission.id
        name = mission.name
        description = mission.description
        launchDesignator = mission.launchDesignator
        type = mission.type
        orbit = Orbit(from: mission.orbit)
    }

    // MARK: Public

    public let id: Int
    public let name: String
    public let description: String?
    public let launchDesignator: String?
    public let type: String
    public let orbit: Orbit

}
