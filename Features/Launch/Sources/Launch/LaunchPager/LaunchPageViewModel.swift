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
        loadBackgroundImage()
    }

    // MARK: Internal

    @Published private(set) var backgroundImage: UIImage?

    let launch: Launch

    var backgroundImagePublisher: Published<UIImage?>.Publisher { $backgroundImage }

    func didTapViewDetails() {
        delegate?.didTapViewDetails(launch: launch)
    }

    // MARK: Private

    private weak var delegate: LaunchPageViewModelDelegate?

    private func loadBackgroundImage() {
        if let url = URL(string: launch.image) {
            Task {
                do {
                    let imageTask = ImagePipeline.shared.imageTask(with: url)
                    backgroundImage = try await imageTask.image
                } catch {
                    print(error)
                }
            }
        } else {
            backgroundImage = RKAssets.Images.placeholder.image
        }
    }

}
