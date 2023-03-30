import Foundation
import TrackXClient

// MARK: - LaunchDetailsLaunchCellModel

struct LaunchDetailsLaunchCellModel: Hashable {

    // MARK: Lifecycle

    public init(launch: LaunchModel) {
        self.launch = launch
    }

    // MARK: Internal

    let launch: LaunchModel
}
