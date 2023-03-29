import RaptorKit
import TrackXClient
import UIKit

public final class LaunchesCoordinator: Coordinator {
    // MARK: - Lifecycle

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public

    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController

    public func start(animated: Bool) {
        let launchesViewModel = LaunchesViewModel(coordinator: self)
        let launchesViewController = LaunchesViewController(viewModel: launchesViewModel)
        navigationController.pushViewController(launchesViewController, animated: animated)
    }

    // MARK: - Private

    private func openLaunchDetails(launch: LaunchModel) {
        let launchDetailsViewModel = LaunchDetailsViewModel(launch: launch)
        let launchDetailsViewController = LaunchDetailsViewController(viewModel: launchDetailsViewModel)
        navigationController.present(launchDetailsViewController, animated: true)
    }
}

extension LaunchesCoordinator: LaunchesViewModelDelegate {
    func didTapLaunchViewDetails(launch: LaunchModel) {
        openLaunchDetails(launch: launch)
    }
}
