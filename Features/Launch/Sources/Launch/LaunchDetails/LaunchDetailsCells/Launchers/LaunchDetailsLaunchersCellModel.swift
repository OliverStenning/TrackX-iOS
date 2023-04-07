import Foundation
import TrackXClient

// MARK: - LaunchDetailsLaunchersCellModel

struct LaunchDetailsLaunchersCellModel: Hashable {

    // MARK: Lifecycle

    public init(launchers: [Launcher]) {
        self.launchers = launchers
    }

    // MARK: Private

    private let launchers: [Launcher]
}
