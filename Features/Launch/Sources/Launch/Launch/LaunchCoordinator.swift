import RaptorKit
import UIKit
import TrackXClient

public final class LaunchCoordinator: Coordinator {
    
    // MARK: - Lifecycle
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public
    
    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    
    public func start(animated: Bool) {
//        let launchViewModel = LaunchViewModel(coordinator: self)
//        let launchViewController = LaunchViewController(viewModel: launchViewModel)
        
        let launchPagerViewController = LaunchPagerViewController()
        navigationController.pushViewController(launchPagerViewController, animated: animated)
    }
    
    // MARK: - Private
    
    private func openLaunchDetails(launch: LaunchModel) {
        let launchDetailsViewModel = LaunchDetailsViewModel(launch: launch)
        let launchDetailsViewController = LaunchDetailsViewController(viewModel: launchDetailsViewModel)
        navigationController.pushViewController(launchDetailsViewController, animated: true)
    }
    
}

extension LaunchCoordinator: LaunchViewModelDelegate {
    
    func didTapUpcomingLaunch(launch: LaunchModel) {
        openLaunchDetails(launch: launch)
    }
    
    func didTapLatestLaunch(launch: LaunchModel) {
        openLaunchDetails(launch: launch)
    }
    
}
