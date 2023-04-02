import Foundation

// MARK: - TCLaunchResponse

// LaunchLibrary v2.2.0 Schema Name:

struct TCLaunchResponse: Codable {

    let count: Int
    let next: String?
    let previous: String?
    let results: [TCLaunch]

}
