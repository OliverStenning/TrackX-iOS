import Foundation

// MARK: - TCLaunchResponse

public struct TCLaunchResponse: Codable {

    public let count: Int
    public let next: String?
    public let previous: String?
    public let results: [TCLaunch]

}
