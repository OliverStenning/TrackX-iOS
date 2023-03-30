import RaptorKit
import TrackXClient
import UIKit

// MARK: - LaunchPageViewModelDelegate

protocol LaunchPageViewModelDelegate: AnyObject {
    func didTapViewDetails(launch: Launch)
}

// MARK: - LaunchPageViewModel

public final class LaunchPageViewModel {

    // MARK: Lifecycle

    init(delegate: LaunchPageViewModelDelegate, launch: Launch) {
        self.delegate = delegate
        self.launch = launch
        launchStatus = "Success"
        launchStatusColor = RKAssets.Colors.success.color.darkOnly
        launchName = launch.name ?? "Unknown"
        launchDate = launch.net ?? "Unknown"
    }

    // MARK: Internal

    let launch: Launch
    let launchStatus: String
    let launchStatusColor: UIColor
    let launchName: String
    let launchDate: String

    func didTapViewDetails() {
        delegate?.didTapViewDetails(launch: launch)
    }

    // MARK: Private

    private weak var delegate: LaunchPageViewModelDelegate?

}
