import RaptorKit
import UIKit

public final class LaunchCoordinator: Coordinator {
    
    // MARK: - Lifecycle
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public
    
    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController
    
    public func start(animated: Bool) {
        let launchViewModel = LaunchViewModel()
        let launchViewController = LaunchViewController(viewModel: launchViewModel)
        navigationController.pushViewController(launchViewController, animated: animated)
    }
    
}
