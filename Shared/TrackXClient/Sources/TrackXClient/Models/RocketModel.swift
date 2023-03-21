import Foundation

public final class RocketModel {
    
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
        self.id = rocket.id
        self.name = rocket.name
        self.active = rocket.active
        self.stages = rocket.stages
        self.boosters = rocket.boosters
        self.launchCost = rocket.launchCost
        self.successRate = rocket.successRate
        self.height = rocket.height
        self.diameter = rocket.diameter
        self.mass = rocket.mass
    }
    
    
}
