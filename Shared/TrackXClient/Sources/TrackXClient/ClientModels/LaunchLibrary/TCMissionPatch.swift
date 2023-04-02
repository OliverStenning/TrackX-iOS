import Foundation

// MARK: - TCMissionPatch

// LaunchLibrary v2.2.0 Schema Name: MissionPatch

struct TCMissionPatch: Codable {

    let id: Int
    let name: String
    let priority: Int?
    let imageUrl: String
    let agency: TCAgency

}
