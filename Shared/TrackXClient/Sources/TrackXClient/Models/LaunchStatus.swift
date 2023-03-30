import Foundation

// MARK: - LaunchStatus

public struct LaunchStatus: Hashable {

    // MARK: Lifecycle

    init(from launchStatus: TCLaunchStatus) {
        id = launchStatus.id
        if let status = launchStatus.abbrev {
            name = status
        } else {
            name = launchStatus.name
        }
        description = launchStatus.description
    }

    // MARK: Public

    public let id: Int
    public let name: String
    public let description: String?

}
