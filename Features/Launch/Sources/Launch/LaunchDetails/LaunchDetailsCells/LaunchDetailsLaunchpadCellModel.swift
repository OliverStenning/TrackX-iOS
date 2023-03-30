import Foundation
import TrackXClient

// MARK: - LaunchDetailsLaunchpadCellModel

struct LaunchDetailsLaunchpadCellModel: Hashable {

    // MARK: Lifecycle

    public init(launch: Launch) {
        self.launch = launch
    }

    // MARK: Internal

    let launch: Launch
}
