import Foundation

// MARK: - RocketV1

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

}
