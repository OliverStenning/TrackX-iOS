import Foundation

// MARK: - TCMissionPatch

public struct TCMissionPatch: Hashable, Codable {

    public let id: Int
    public let name: String
    public let priority: Int?
    public let imageUrl: String
    public let agency: TCAgency

}
