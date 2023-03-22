import Foundation
import TrackXClient

// MARK: - LaunchInfoViewModel

struct LaunchInfoViewModel: Hashable {
    
    // MARK: - Lifecycle
    
    public init(launch: LaunchModel) {
        self.name = launch.name
        self.rocket = launch.rocket.name ?? "Falcon 9"
        self.launchpad = launch.launchpad.name
        self.date = launch.dateUtc
    }
    
    // MARK: - Internal
    
    let name: String
    let rocket: String
    let launchpad: String
    let date: String
    
}
