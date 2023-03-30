import Foundation
import TrackXClient

// MARK: - LaunchDetailsRocketCellModel

struct LaunchDetailsRocketCellModel: Hashable {

    // MARK: Lifecycle

    public init(launch: LaunchModel) {
        self.launch = launch
    }

    // MARK: Internal

    let launch: LaunchModel
}
