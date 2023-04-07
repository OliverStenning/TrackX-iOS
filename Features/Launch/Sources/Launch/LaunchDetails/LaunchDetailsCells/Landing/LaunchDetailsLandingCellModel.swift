import Foundation
import TrackXClient

// MARK: - LaunchDetailsLandingCellModel

struct LaunchDetailsLandingCellModel: Hashable {

    // MARK: Lifecycle

    public init(landing: Landing) {
        self.landing = landing
    }

    // MARK: Private

    private let landing: Landing
}
