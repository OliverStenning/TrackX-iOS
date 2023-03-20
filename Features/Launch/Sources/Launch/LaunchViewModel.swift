import Combine
import Foundation

// MARK: - LaunchSection

enum LaunchSection {
    case upcoming
    case latest
}

// MARK: - LaunchCellType

enum LaunchCellType: Hashable {
    case upcoming(UpcomingLaunchCellViewModel)
    case latest(LatestLaunchCellViewModel)
}

public final class LaunchViewModel {
    
    // MARK: - Lifecycle
    
    init() {
        setSections()
    }
    
    // MARK: - Internal
    
    @Published private(set) var sections = [LaunchSection]()
    
    var sectionsPublisher: Published<[LaunchSection]>.Publisher { $sections }
    
    var title: String { "Launches" }
    
    // MARK: - Private
    
    private func setSections() {
        sections = [
            .upcoming,
            .latest
        ]
    }
    
}
