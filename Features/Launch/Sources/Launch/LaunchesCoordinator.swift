import RaptorKit
import TrackXClient
import UIKit

// MARK: - LaunchesCoordinator

public final class LaunchesCoordinator: Coordinator {

    // MARK: Lifecycle

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Public

    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController

    public func start(animated: Bool) {
        let launchesViewModel = LaunchesViewModel(coordinator: self)
        let launchesViewController = LaunchesViewController(viewModel: launchesViewModel)
        navigationController.pushViewController(launchesViewController, animated: animated)
    }

    // MARK: Private

    private func openLaunchDetails(launch: Launch) {
        let launchDetailsViewModel = LaunchDetailsViewModel(launch: launch)
        let launchDetailsViewController = LaunchDetailsViewController(viewModel: launchDetailsViewModel)
        navigationController.present(launchDetailsViewController, animated: true)
    }
}

// MARK: LaunchesViewModelDelegate

extension LaunchesCoordinator: LaunchesViewModelDelegate {
    func didTapLaunchViewDetails(launch: Launch) {
        openLaunchDetails(launch: launch)
    }
}
