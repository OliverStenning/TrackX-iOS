import Foundation
import TrackXClient

// MARK: - LatestLaunchCellViewModel

struct LatestLaunchCellViewModel: Hashable {
    
    // MARK: - Lifecycle
    
    public init(latestLaunch: LaunchModel) {
        self.launch = latestLaunch
        self.launchInfoViewModel = LaunchInfoViewModel(launch: latestLaunch)
    }
    
    // MARK: - Internal
    
    let launch: LaunchModel
    let launchInfoViewModel: LaunchInfoViewModel
    
}
