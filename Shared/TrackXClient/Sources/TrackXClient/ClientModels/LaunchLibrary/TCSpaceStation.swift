import Foundation

// MARK: - TCSpaceStation

// LaunchLibrary v2.2.0 Schema Name: SpaceStationSerializerForCommon

struct TCSpaceStation: Codable {

    let id: Int
    let url: String
    let name: String
    let status: TCSpaceStationStatus
    let founded: String
    let description: String
    let orbit: String
    let imageUrl: String?

}
