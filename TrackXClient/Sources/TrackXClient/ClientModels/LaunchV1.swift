import Foundation

final class LaunchV1: Codable {
    
    let id: UUID
    let name: String
    let dateUtc: String
    let upcoming: Bool
    let success: Bool?
    let description: String?
    let rocket: RocketV1
    let cores: String
    let payloads: String
    let launchpad: LaunchpadV1
    
    init(
        id: UUID,
        name: String,
        dateUtc: String,
        upcoming: Bool,
        success: Bool?,
        description: String?,
        rocket: RocketV1,
        cores: String,
        payloads: String,
        launchpad: LaunchpadV1
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dateUtc = "date_utc"
        case upcoming
        case success
        case description
        case rocket
        case cores
        case payloads
        case launchpad
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.dateUtc = try container.decode(String.self, forKey: .dateUtc)
        self.upcoming = try container.decode(Bool.self, forKey: .upcoming)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.rocket = try container.decode(RocketV1.self, forKey: .rocket)
        self.cores = try container.decode(String.self, forKey: .cores)
        self.payloads = try container.decode(String.self, forKey: .payloads)
        self.launchpad = try container.decode(LaunchpadV1.self, forKey: .launchpad)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.dateUtc, forKey: .dateUtc)
        try container.encode(self.upcoming, forKey: .upcoming)
        try container.encodeIfPresent(self.success, forKey: .success)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encode(self.rocket, forKey: .rocket)
        try container.encode(self.cores, forKey: .cores)
        try container.encode(self.payloads, forKey: .payloads)
        try container.encode(self.launchpad, forKey: .launchpad)
    }

}
