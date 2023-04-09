import Foundation
import RaptorKit
import TrackXClient
import Utilities

final class SetupManager {

    // MARK: Lifecycle

    init(persistence: PersistenceManaging = PersistenceManager.shared) {
        self.persistence = persistence
    }

    // MARK: Internal

    func setup() {
        print("Current configuration: \(BuildConfiguration.shared.environment)")
        setupAppAppearance()
        setupFirstLaunch()
        setupNetworking()
    }

    // MARK: Private

    private let persistence: PersistenceManaging

    private func setupAppAppearance() {
        AppAppearance.setup()
    }

    private func setupFirstLaunch() {
        if persistence.date(forKey: .firstAppLaunchDate) == nil {
            persistence.setDate(Date(), forKey: .firstAppLaunchDate)
        }
        persistence.incrementInteger(forKey: .numberOfAppLaunches)

        print("Number of app launches: \(persistence.integer(forKey: .numberOfAppLaunches))")
        print("First app launch date: \(String(describing: persistence.date(forKey: .firstAppLaunchDate)))")
    }

    private func setupNetworking() {
        TrackXClient.setup(with: BuildConfiguration.shared.config)
    }

}
