import RaptorKit
import TrackXClient
import UIKit
import Utilities

// MARK: - LaunchInfoViewModel

struct LaunchInfoViewModel: Hashable {

    // MARK: Lifecycle

    public init(launch: Launch, backgroundType: BackgroundType = .automatic) {
        self.launch = launch
        self.backgroundType = backgroundType
    }

    // MARK: Internal

    enum BackgroundType {
        case image
        case automatic
    }

    var statusText: String {
        launch.status.name
    }

    var statusColor: UIColor {
        switch (launch.status.type, backgroundType) {
        case (.scheduled, .image): return RKAssets.Colors.accent2.color.darkOnly
        case (.scheduled, .automatic): return RKAssets.Colors.accent2.color
        case (.success, _): return RKAssets.Colors.success.color
        case (.failure, _): return RKAssets.Colors.failure.color
        }
    }

    var nameText: String {
        launch.name
    }

    var nameColor: UIColor {
        switch backgroundType {
        case .image: return RKAssets.Colors.neutral1.color.darkOnly
        case .automatic: return RKAssets.Colors.neutral1.color
        }
    }

    var dateText: String {
        LaunchDateFormatter.shared.format(launch.net) ?? L10n.LaunchInfoView.Date.unknown
    }

    var dateColor: UIColor {
        switch backgroundType {
        case .image: return RKAssets.Colors.neutral3.color.darkOnly
        case .automatic: return RKAssets.Colors.neutral3.color
        }
    }

    // MARK: Private

    private let launch: Launch
    private let backgroundType: BackgroundType

}
