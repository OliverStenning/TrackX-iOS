import Foundation

// MARK: - TCProgram

public struct TCProgram: Hashable, Codable {

    public let id: Int
    public let url: String
    public let name: String
    public let description: String?
    public let agencies: [TCAgency]
    public let imageUrl: String
    public let startDate: String?
    public let endDate: String?
    public let infoUrl: String?
    public let wikiUrl: String?
    public let missionPatches: [TCMissionPatch]

}
