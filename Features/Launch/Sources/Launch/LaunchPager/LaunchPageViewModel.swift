import Nuke
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
        loadBackgroundImage()
    }

    // MARK: Internal

    @Published private(set) var backgroundImage: UIImage?

    let launch: Launch
    let launchStatus: String
    let launchStatusColor: UIColor
    let launchName: String
    let launchDate: String

    var backgroundImagePublisher: Published<UIImage?>.Publisher { $backgroundImage }

    func didTapViewDetails() {
        delegate?.didTapViewDetails(launch: launch)
    }

    // MARK: Private

    private weak var delegate: LaunchPageViewModelDelegate?

    private func loadBackgroundImage() {
        guard let url = URL(string: launch.image) else { return }

        Task {
            do {
                let imageTask = ImagePipeline.shared.imageTask(with: url)
                backgroundImage = try await imageTask.image
            } catch {
                print(error)
            }
        }
    }

}
