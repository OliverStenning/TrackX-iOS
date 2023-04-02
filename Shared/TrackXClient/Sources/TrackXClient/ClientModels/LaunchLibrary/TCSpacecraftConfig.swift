import Foundation

// MARK: - TCSpacecraftConfig

// LaunchLibrary v2.2.0 Schema Name: SpacecraftConfigurationDetail

struct TCSpacecraftConfig: Codable {

    let id: Int
    let url: String
    let name: String
    let type: TCSpacecraftConfigType
    let agency: TCAgency
    let inUse: Bool?
    let capability: String?
    let history: String?
    let details: String?
    let maidenFlight: String?
    let height: Double?
    let diameter: Double?
    let humanRated: Bool?
    let crewCapacity: Int?
    let payloadCapacity: Int?
    let flightLife: String?
    let imageUrl: String?
    let nationUrl: String?
    let wikiLink: String?
    let infoLink: String?

}
