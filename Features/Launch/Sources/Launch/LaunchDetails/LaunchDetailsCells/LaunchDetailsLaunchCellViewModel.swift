import Foundation
import TrackXClient

// MARK: - LaunchDetailsLaunchCellViewModel

struct LaunchDetailsLaunchCellViewModel: Hashable {

    // MARK: Lifecycle

    public init(launch: LaunchModel) {
        self.launch = launch
    }

    // MARK: Internal

    let launch: LaunchModel
}
