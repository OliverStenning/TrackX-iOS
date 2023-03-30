import RaptorKit
import TrackXClient
import UIKit

// MARK: - LaunchPageViewModelDelegate

protocol LaunchPageViewModelDelegate: AnyObject {
    func didTapViewDetails(launch: LaunchModel)
}

// MARK: - LaunchPageViewModel

public final class LaunchPageViewModel {

    // MARK: Lifecycle

//    init(delegate: LaunchPageViewModelDelegate, launch: LaunchModel) {
    init(delegate: LaunchPageViewModelDelegate, launch: TCLaunch) {
        self.delegate = delegate
        self.launch = launch
        launchStatus = "Success"
        launchStatusColor = RKAssets.Colors.success.color.darkOnly
        launchName = launch.name ?? "Unknown"
        launchDate = launch.net ?? "Unknown"
    }

    // MARK: Internal

//    let launch: LaunchModel
    let launch: TCLaunch
    let launchStatus: String
    let launchStatusColor: UIColor
    let launchName: String
    let launchDate: String

    func didTapViewDetails() {
//        delegate?.didTapViewDetails(launch: launch)
        delegate?.didTapViewDetails(launch: .mock())
    }

    // MARK: Private

    private weak var delegate: LaunchPageViewModelDelegate?

}
