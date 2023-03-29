import Foundation

public struct RocketModel: Hashable {
    public let id: UUID
    public let name: String?
    public let active: Bool?
    public let stages: Int?
    public let boosters: Int?
    public let launchCost: Int?
    public let successRate: Int?
    public let height: Double
    public let diameter: Double
    public let mass: Double

    init(
        id: UUID,
        name: String?,
        active: Bool?,
        stages: Int?,
        boosters: Int?,
        launchCost: Int?,
        successRate: Int?,
        height: Double,
        diameter: Double,
        mass: Double
    ) {
        self.id = id
        self.name = name
        self.active = active
        self.stages = stages
        self.boosters = boosters
        self.launchCost = launchCost
        self.successRate = successRate
        self.height = height
        self.diameter = diameter
        self.mass = mass
    }

    init(from rocket: RocketV1) {
        id = rocket.id
        name = rocket.name
        active = rocket.active
        stages = rocket.stages
        boosters = rocket.boosters
        launchCost = rocket.launchCost
        successRate = rocket.successRate
        height = rocket.height
        diameter = rocket.diameter
        mass = rocket.mass
    }
}
