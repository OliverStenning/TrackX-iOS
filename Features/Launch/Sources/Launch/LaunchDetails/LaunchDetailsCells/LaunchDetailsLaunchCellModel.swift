import Foundation
import TrackXClient

// MARK: - LaunchDetailsLaunchCellModel

struct LaunchDetailsLaunchCellModel: Hashable {

    // MARK: Lifecycle

    public init(launch: Launch) {
        self.launch = launch
    }

    // MARK: Internal

    let launch: Launch
}
