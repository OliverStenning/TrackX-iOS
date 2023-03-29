import UIKit

// MARK: - Coordinator

public protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start(animated: Bool)
}

extension Coordinator {
    func start() {
        start(animated: true)
    }
}
