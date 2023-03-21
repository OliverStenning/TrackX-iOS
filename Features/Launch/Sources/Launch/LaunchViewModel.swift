import Combine
import Foundation
import TrackXClient

// MARK: - LaunchSection

enum LaunchSection: Hashable {
    case upcoming(UpcomingLaunchCellViewModel)
    case latest(LatestLaunchCellViewModel)
}

// MARK: - LaunchCellType

enum LaunchCellType: Hashable {
    case upcoming(UpcomingLaunchCellViewModel)
    case latest(LatestLaunchCellViewModel)
}

public final class LaunchViewModel {
    
    // MARK: - Lifecycle
    
    init(launchService: LaunchServiceProtocol = LaunchService()) {
        self.launchService = launchService
    }
    
    // MARK: - Internal
    
    @Published private(set) var sections = [LaunchSection]()
    
    var sectionsPublisher: Published<[LaunchSection]>.Publisher { $sections }
    
    var title: String { "Launches" }
    
    func loadLaunches() {
        getLaunchData()
    }
    
    // MARK: - Private
    
    private let launchService: LaunchServiceProtocol
    
    private func getLaunchData() {
        Task {
            do {
                async let latestLaunch = launchService.getLatestLaunch()
                async let upcomingLaunch = launchService.getNextLaunch()
                try await handleLaunchDataSuccess(latestLaunch: latestLaunch, upcomingLaunch: upcomingLaunch)
            } catch {
                // TODO: Show error screen
            }
        }
    }
    
    @MainActor
    private func handleLaunchDataSuccess(latestLaunch: LaunchModel, upcomingLaunch: LaunchModel) {
        let latestLaunchViewModel = LatestLaunchCellViewModel(latestLaunch: latestLaunch)
        let upcomingLaunchViewModel = UpcomingLaunchCellViewModel(upcomingLaunch: upcomingLaunch)
        
        sections = [
            .upcoming(upcomingLaunchViewModel),
            .latest(latestLaunchViewModel)
        ]
    }
    
}
