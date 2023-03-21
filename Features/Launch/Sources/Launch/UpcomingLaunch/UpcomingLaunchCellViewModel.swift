import Foundation
import TrackXClient

// MARK: - UpcomingLaunchCellViewModel

struct UpcomingLaunchCellViewModel: Hashable {
    
    // MARK: - Lifecycle
    
    public init(upcomingLaunch: LaunchModel) {
        self.launchInfoViewModel = LaunchInfoViewModel(launch: upcomingLaunch)
    }
    
    // MARK: - Internal
    
    let launchInfoViewModel: LaunchInfoViewModel
    
}
