import Foundation
import TrackXClient

// MARK: - LaunchDetailsHeaderCellViewModel

struct LaunchDetailsHeaderCellViewModel: Hashable {
    // MARK: - Lifecycle

    public init(launch: LaunchModel) {
        self.launch = launch
    }

    // MARK: - Internal

    let launch: LaunchModel
}
