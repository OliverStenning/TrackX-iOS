import Foundation

final class LaunchpadV1: Codable {
    
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case region
        case longitude
        case latitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.region = try container.decode(String.self, forKey: .region)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.fullName, forKey: .fullName)
        try container.encode(self.region, forKey: .region)
        try container.encode(self.longitude, forKey: .longitude)
        try container.encode(self.latitude, forKey: .latitude)
    }
    
}
