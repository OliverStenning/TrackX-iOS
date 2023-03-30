import Foundation

// MARK: - TCLaunchStatus

public struct TCLaunchStatus: Hashable, Codable {

    public let id: Int
    public let name: String
    public let abbrev: String?
    public let description: String?

}
