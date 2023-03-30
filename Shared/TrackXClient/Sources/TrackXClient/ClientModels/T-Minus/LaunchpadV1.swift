import Foundation

// MARK: - LaunchpadV1

final class LaunchpadV1: Codable {

    let id: UUID
    let name: String
    let fullName: String
    let region: String
    let longitude: Double
    let latitude: Double

}
