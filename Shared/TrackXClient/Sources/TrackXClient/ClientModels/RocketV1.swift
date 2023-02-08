import Foundation

final class RocketV1: Codable {
    
    let id: UUID
    let name: String?
    let active: Bool?
    let stages: Int?
    let boosters: Int?
    let launchCost: Int?
    let successRate: Int?
    let height: Double
    let diameter: Double
    let mass: Double
    
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case active
        case stages
        case boosters
        case launchCost = "launch_cost"
        case successRate = "success_rate"
        case height
        case diameter
        case mass
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.active = try container.decodeIfPresent(Bool.self, forKey: .active)
        self.stages = try container.decodeIfPresent(Int.self, forKey: .stages)
        self.boosters = try container.decodeIfPresent(Int.self, forKey: .boosters)
        self.launchCost = try container.decodeIfPresent(Int.self, forKey: .launchCost)
        self.successRate = try container.decodeIfPresent(Int.self, forKey: .successRate)
        self.height = try container.decode(Double.self, forKey: .height)
        self.diameter = try container.decode(Double.self, forKey: .diameter)
        self.mass = try container.decode(Double.self, forKey: .mass)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.active, forKey: .active)
        try container.encodeIfPresent(self.stages, forKey: .stages)
        try container.encodeIfPresent(self.boosters, forKey: .boosters)
        try container.encodeIfPresent(self.launchCost, forKey: .launchCost)
        try container.encodeIfPresent(self.successRate, forKey: .successRate)
        try container.encode(self.height, forKey: .height)
        try container.encode(self.diameter, forKey: .diameter)
        try container.encode(self.mass, forKey: .mass)
    }
    
}
