import Combine
import Foundation
import TrackXClient

// MARK: - LaunchDetailsSection

enum LaunchDetailsSection: Hashable {
    case header(LaunchDetailsHeaderCellViewModel)
    case launch(LaunchDetailsLaunchCellViewModel)
    case rocket(LaunchDetailsRocketCellViewModel)
    case launchpad(LaunchDetailsLaunchpadCellViewModel)
}

// MARK: - LaunchDetailsCellType

enum LaunchDetailsCellType: Hashable {
    case header(LaunchDetailsHeaderCellViewModel)
    case launch(LaunchDetailsLaunchCellViewModel)
    case rocket(LaunchDetailsRocketCellViewModel)
    case launchpad(LaunchDetailsLaunchpadCellViewModel)
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

    var title: String { "Launch Info" }

    // MARK: Private

    private let launch: LaunchModel

    private func setSections() {
        sections = [
            .header(LaunchDetailsHeaderCellViewModel(launch: launch)),
            .launch(LaunchDetailsLaunchCellViewModel(launch: launch)),
            .rocket(LaunchDetailsRocketCellViewModel(launch: launch)),
            .launchpad(LaunchDetailsLaunchpadCellViewModel(launch: launch))
        ]
    }
}
