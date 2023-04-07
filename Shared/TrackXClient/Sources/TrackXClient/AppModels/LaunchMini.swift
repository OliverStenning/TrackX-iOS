import Foundation

// MARK: - LaunchMini

public struct LaunchMini: Hashable {

    // MARK: Lifecycle

    init(from launchMini: TCLaunchMini) {
        id = launchMini.id
        name = launchMini.name
    }

    // MARK: Public

    public let id: String
    public let name: String?

}
