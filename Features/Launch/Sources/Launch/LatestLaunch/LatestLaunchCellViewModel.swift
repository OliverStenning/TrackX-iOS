import Foundation
import TrackXClient

// MARK: - LatestLaunchCellViewModel

struct LatestLaunchCellViewModel: Hashable {
    
    // MARK: - Lifecycle
    
    public init(latestLaunch: LaunchModel) {
        self.launchInfoViewModel = LaunchInfoViewModel(launch: latestLaunch)
    }
    
    // MARK: - Internal
    
    let launchInfoViewModel: LaunchInfoViewModel
    
}
