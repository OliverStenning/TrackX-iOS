import Foundation

// MARK: - TCLauncherConfig

public struct TCLauncherConfig: Codable {

    public let id: Int
    public let url: String
    public let name: String
    public let family: String?
    public let fullName: String?
    public let variant: String?

}
