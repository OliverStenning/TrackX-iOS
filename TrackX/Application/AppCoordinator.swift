import Launch
import RaptorKit
import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Lifecycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    // MARK: - Internal
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    func start(animated: Bool) {
        let launchCoordinator = LaunchCoordinator(navigationController: navigationController)
        childCoordinators.append(launchCoordinator)
        launchCoordinator.start(animated: animated)
    }
    
}
