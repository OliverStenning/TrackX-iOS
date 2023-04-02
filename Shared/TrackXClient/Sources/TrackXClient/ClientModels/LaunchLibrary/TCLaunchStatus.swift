import Foundation

// MARK: - TCLaunchStatus

// LaunchLibrary v2.2.0 Schema Name: LaunchStatus

public struct TCLaunchStatus: Codable {

    public let id: Int
    public let name: String
    public let abbrev: String?
    public let description: String?

}
