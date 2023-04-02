import Foundation
import TrackXClient

// MARK: - LaunchDetailsRocketCellModel

struct LaunchDetailsRocketCellModel: Hashable {

    // MARK: Lifecycle

    public init(rocket: Rocket) {
        self.rocket = rocket
    }

    // MARK: Internal

    var nameLabelText: String {
        ""
    }

    var nameText: String {
        rocket.name
    }

    var variantLabelText: String {
        ""
    }

    var variantText: String {
        rocket.variant ?? ""
    }

    // MARK: Private

    private let rocket: Rocket
}
