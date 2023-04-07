import Foundation
import TrackXClient

// MARK: - LaunchDetailsMissionCellModel

struct LaunchDetailsMissionCellModel: Hashable {

    // MARK: Lifecycle

    public init(mission: Mission) {
        self.mission = mission
    }

    // MARK: Private

    private let mission: Mission
}
