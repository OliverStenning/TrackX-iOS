import Foundation
import RaptorKit
import TrackXClient

enum SetupManager {

    // MARK: Internal

    static func setup() {
        print("Current configuration: \(BuildConfiguration.shared.environment)")
        setupAppAppearance()
        setupFirstLaunch()
        setupNetworking()
    }

    // MARK: Private

    private static func setupAppAppearance() {
        AppAppearance.setup()
    }

    private static func setupFirstLaunch() {
        // TODO: Store first launch in UserDefaults
    }

    private static func setupNetworking() {
        TrackXClient.setup(with: BuildConfiguration.shared.config)
    }

}
