import Foundation
import TrackXClient

// MARK: - LaunchDetailsRocketCellViewModel

struct LaunchDetailsRocketCellViewModel: Hashable {

    // MARK: Lifecycle

    public init(launch: LaunchModel) {
        self.launch = launch
    }

    // MARK: Internal

    let launch: LaunchModel
}
