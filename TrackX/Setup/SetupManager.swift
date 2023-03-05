import Foundation
import RaptorKit

enum SetupManager {
    
    // MARK: - Internal
    
    static func setup() {
        setupAppAppearance()
        setupFirstLaunch()
    }
    
    // MARK: - Private
    
    private static func setupAppAppearance() {
        AppAppearance.setup()
    }
    
    private static func setupFirstLaunch() {
        // TODO: Store first launch in UserDefaults
    }
    
}
