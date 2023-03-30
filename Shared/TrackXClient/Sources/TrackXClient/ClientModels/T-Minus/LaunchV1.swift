import Foundation

// MARK: - LaunchV1

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

}
