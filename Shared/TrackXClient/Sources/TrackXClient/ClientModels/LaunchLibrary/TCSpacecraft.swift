import Foundation

// MARK: - TCSpacecraft

// LaunchLibrary v2.2.0 Schema Name: SpacecraftDetailedNoFlights

struct TCSpacecraft: Codable {

    let id: Int
    let url: String
    let name: String
    let serialNumber: String?
    let status: TCSpacecraftStatus
    let description: String
    let spacecraftConfig: TCSpacecraftConfig

}
