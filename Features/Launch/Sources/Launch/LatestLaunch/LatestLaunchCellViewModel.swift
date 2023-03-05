import Foundation

// MARK: - LatestLaunchCellViewModel

struct LatestLaunchCellViewModel: Hashable {
    
    // MARK: - Lifecycle
    
    public init() {
        self.name = "Crew 4"
        self.rocket = "Falcon 9"
        self.launchpad = "LC39A Kennedy Space Center"
    }
    
    // MARK: - Internal
    
    let name: String
    let rocket: String
    let launchpad: String
    
}
