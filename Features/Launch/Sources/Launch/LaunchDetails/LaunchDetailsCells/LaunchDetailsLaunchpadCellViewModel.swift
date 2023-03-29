import Foundation
import TrackXClient

// MARK: - LaunchDetailsLaunchpadCellViewModel

struct LaunchDetailsLaunchpadCellViewModel: Hashable {
    // MARK: - Lifecycle

    public init(launch: LaunchModel) {
        self.launch = launch
    }

    // MARK: - Internal

    let launch: LaunchModel
}
