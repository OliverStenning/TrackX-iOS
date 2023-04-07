import Foundation

// MARK: - TCLaunchStatus

// LaunchLibrary v2.2.0 Schema Name: LaunchStatus

struct TCLaunchStatus: Codable {

    let id: Int
    let name: String
    let abbrev: String?
    let description: String?

}
