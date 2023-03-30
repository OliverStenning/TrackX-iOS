import Combine
import Foundation
import TrackXClient

// MARK: - LaunchDetailsSection

enum LaunchDetailsSection: Hashable {
    case launch(LaunchDetailsLaunchCellModel)
    case rocket(LaunchDetailsRocketCellModel)
    case launchpad(LaunchDetailsLaunchpadCellModel)
}

// MARK: - LaunchDetailsCellType

enum LaunchDetailsCellType: Hashable {
    case launch(LaunchDetailsLaunchCellModel)
    case rocket(LaunchDetailsRocketCellModel)
    case launchpad(LaunchDetailsLaunchpadCellModel)
}

// MARK: - LaunchDetailsViewModel

public final class LaunchDetailsViewModel {

    // MARK: Lifecycle

    init(launch: LaunchModel) {
        self.launch = launch
        setSections()
    }

    // MARK: Internal

    @Published private(set) var sections = [LaunchDetailsSection]()

    var sectionsPublisher: Published<[LaunchDetailsSection]>.Publisher { $sections }

    // MARK: Private

    private let launch: LaunchModel

    private func setSections() {
        sections = [
            .launch(LaunchDetailsLaunchCellModel(launch: launch)),
            .rocket(LaunchDetailsRocketCellModel(launch: launch)),
            .launchpad(LaunchDetailsLaunchpadCellModel(launch: launch))
        ]
    }
}
