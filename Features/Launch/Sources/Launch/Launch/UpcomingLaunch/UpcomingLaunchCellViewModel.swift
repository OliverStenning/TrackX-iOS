import Foundation
import TrackXClient

// MARK: - UpcomingLaunchCellViewModel

struct UpcomingLaunchCellViewModel: Hashable {
    
    // MARK: - Lifecycle
    
    public init(upcomingLaunch: LaunchModel) {
        self.launch = upcomingLaunch
        self.launchInfoViewModel = LaunchInfoViewModel(launch: upcomingLaunch)
    }
    
    // MARK: - Internal
    
    let launch: LaunchModel
    let launchInfoViewModel: LaunchInfoViewModel
    
}
