import Foundation

// MARK: - LaunchInfoViewModel

struct LaunchInfoViewModel: Hashable {
    
    // MARK: - Lifecycle
    
    public init() {
        self.name = "Crew 4"
        self.rocket = "Falcon 9"
        self.launchpad = "LC39A Kennedy Space Center"
        self.date = "28 Oct 2022, 12:00 UTC"
    }
    
    // MARK: - Internal
    
    let name: String
    let rocket: String
    let launchpad: String
    let date: String
    
}
