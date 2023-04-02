import Foundation

// MARK: - TCProgram

// LaunchLibrary v2.2.0 Schema Name: Program

struct TCProgram: Codable {

    let id: Int
    let url: String
    let name: String
    let description: String?
    let agencies: [TCAgency]
    let imageUrl: String
    let startDate: String?
    let endDate: String?
    let infoUrl: String?
    let wikiUrl: String?
    let missionPatches: [TCMissionPatch]

}
