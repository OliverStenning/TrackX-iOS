import Foundation

final class RocketV1: Codable {

    // MARK: Lifecycle

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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        active = try container.decodeIfPresent(Bool.self, forKey: .active)
        stages = try container.decodeIfPresent(Int.self, forKey: .stages)
        boosters = try container.decodeIfPresent(Int.self, forKey: .boosters)
        launchCost = try container.decodeIfPresent(Int.self, forKey: .launchCost)
        successRate = try container.decodeIfPresent(Int.self, forKey: .successRate)
        height = try container.decode(Double.self, forKey: .height)
        diameter = try container.decode(Double.self, forKey: .diameter)
        mass = try container.decode(Double.self, forKey: .mass)
    }

    // MARK: Internal

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

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(active, forKey: .active)
        try container.encodeIfPresent(stages, forKey: .stages)
        try container.encodeIfPresent(boosters, forKey: .boosters)
        try container.encodeIfPresent(launchCost, forKey: .launchCost)
        try container.encodeIfPresent(successRate, forKey: .successRate)
        try container.encode(height, forKey: .height)
        try container.encode(diameter, forKey: .diameter)
        try container.encode(mass, forKey: .mass)
    }
}
