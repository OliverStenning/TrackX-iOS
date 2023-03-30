import Combine
import Foundation
import TrackXClient

// MARK: - LaunchesViewModelDelegate

protocol LaunchesViewModelDelegate: AnyObject {
    func didTapLaunchViewDetails(launch: Launch)
}

// MARK: - LaunchesViewModel

public final class LaunchesViewModel {

    // MARK: Lifecycle

    init(coordinator: LaunchesViewModelDelegate, launchService: LaunchServiceProtocol = LaunchService()) {
        self.coordinator = coordinator
        self.launchService = launchService
    }

    // MARK: Internal

    enum State: Equatable {
        case initial
        case loading
        case refreshing
        case loaded
        case error
    }

    @Published private(set) var state: State = .initial
    @Published private(set) var pageModels = [LaunchPageViewModel]()

    var statePublisher: Published<State>.Publisher { $state }
    var pageModelsPublisher: Published<[LaunchPageViewModel]>.Publisher { $pageModels }

    func loadLaunches() {
        state = .loading
        getLaunchData()
    }

    func refreshLaunches() {
        state = .refreshing
        getLaunchData()
    }

    func didTapLaunchViewDetails(launch: Launch) {
        coordinator?.didTapLaunchViewDetails(launch: launch)
    }

    // MARK: Private

    private let launchService: LaunchServiceProtocol
    private weak var coordinator: LaunchesViewModelDelegate?

    private func getLaunchData() {
        Task {
            do {
                async let latestLaunches = launchService.getLatest()
                async let upcomingLaunches = launchService.getUpcoming()
                try await handleLaunchDataSuccess(latestLaunches: latestLaunches, upcomingLaunches: upcomingLaunches)
            } catch {
                print(error)
                await handleLaunchDataError()
            }
        }
    }

    @MainActor
    private func handleLaunchDataSuccess(latestLaunches: [Launch], upcomingLaunches: [Launch]) {
        var launchModels = upcomingLaunches.map { LaunchPageViewModel(delegate: self, launch: $0) }
        launchModels += latestLaunches.map { LaunchPageViewModel(delegate: self, launch: $0) }
        pageModels = launchModels

        // Not a fan of this but makes the UX feel better
        let delay = state == .refreshing ? 0.5 : 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.state = .loaded
        }
    }

    @MainActor
    private func handleLaunchDataError() {
        state = .error
    }
}

// MARK: LaunchPageViewModelDelegate

extension LaunchesViewModel: LaunchPageViewModelDelegate {
    func didTapViewDetails(launch: Launch) {
        coordinator?.didTapLaunchViewDetails(launch: launch)
    }
}
