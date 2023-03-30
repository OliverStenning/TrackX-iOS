import Foundation

// MARK: - LaunchStatus

public struct LaunchStatus: Hashable {

    // MARK: Lifecycle

    init(from launchStatus: TCLaunchStatus) {
        id = launchStatus.id
        if let abbrev = launchStatus.abbrev, abbrev == "Success" || abbrev == "Failure" {
            name = abbrev
            if abbrev == "Success" {
                type = .success
            } else if abbrev == "Failure" {
                type = .failure
            } else {
                type = .scheduled
            }
        } else {
            name = launchStatus.name
            type = .scheduled
        }
        description = launchStatus.description
    }

    // MARK: Public

    public enum StatusType {
        case scheduled
        case success
        case failure
    }

    public let id: Int
    public let name: String
    public let type: StatusType
    public let description: String?

}
