import Foundation
import TrackXClient

// MARK: - LaunchDetailsLocationCellModel

struct LaunchDetailsLocationCellModel: Hashable {

    // MARK: Lifecycle

    public init(location: Location) {
        self.location = location
    }

    // MARK: Private

    private let location: Location
}
