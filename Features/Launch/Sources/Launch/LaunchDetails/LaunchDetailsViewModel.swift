import Combine
import Foundation
import TrackXClient

// MARK: - LaunchDetailsSection

enum LaunchDetailsSection: Hashable {
    case launch(LaunchDetailsLaunchCellModel)
    case rocket(LaunchDetailsRocketCellModel)
    case launchers(LaunchDetailsLaunchersCellModel)
    case launchpad(LaunchDetailsLaunchpadCellModel)
    case landing(LaunchDetailsLandingCellModel)
    case mission(LaunchDetailsMissionCellModel)
    case location(LaunchDetailsLocationCellModel)
}

// MARK: - LaunchDetailsCellType

enum LaunchDetailsCellType: Hashable {
    case launch(LaunchDetailsLaunchCellModel)
    case rocket(LaunchDetailsRocketCellModel)
    case launchers(LaunchDetailsLaunchersCellModel)
    case launchpad(LaunchDetailsLaunchpadCellModel)
    case landing(LaunchDetailsLandingCellModel)
    case mission(LaunchDetailsMissionCellModel)
    case location(LaunchDetailsLocationCellModel)
}

// MARK: - LaunchDetailsViewModel

public final class LaunchDetailsViewModel {

    // MARK: Lifecycle

    init(launch: Launch) {
        self.launch = launch
        setSections()
    }

    // MARK: Internal

    @Published private(set) var sections = [LaunchDetailsSection]()

    var sectionsPublisher: Published<[LaunchDetailsSection]>.Publisher { $sections }

    // MARK: Private

    private let launch: Launch

    private func setSections() {
        sections = [
            .launch(LaunchDetailsLaunchCellModel(launch: launch)),
            .rocket(LaunchDetailsRocketCellModel(rocket: launch.rocket)),
            .launchpad(LaunchDetailsLaunchpadCellModel(launch: launch))
        ]
    }
}
