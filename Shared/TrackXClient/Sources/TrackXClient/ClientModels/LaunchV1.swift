import Foundation

final class LaunchV1: Codable {

    // MARK: Lifecycle

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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        dateUtc = try container.decode(String.self, forKey: .dateUtc)
        upcoming = try container.decode(Bool.self, forKey: .upcoming)
        success = try container.decodeIfPresent(Bool.self, forKey: .success)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        rocket = try container.decode(RocketV1.self, forKey: .rocket)
        cores = try container.decode(String.self, forKey: .cores)
        payloads = try container.decode(String.self, forKey: .payloads)
        launchpad = try container.decode(LaunchpadV1.self, forKey: .launchpad)
    }

    // MARK: Internal

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

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(dateUtc, forKey: .dateUtc)
        try container.encode(upcoming, forKey: .upcoming)
        try container.encodeIfPresent(success, forKey: .success)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encode(rocket, forKey: .rocket)
        try container.encode(cores, forKey: .cores)
        try container.encode(payloads, forKey: .payloads)
        try container.encode(launchpad, forKey: .launchpad)
    }
}
