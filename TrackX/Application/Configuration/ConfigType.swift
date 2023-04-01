import Foundation
import TrackXClient

// MARK: - ConfigType

protocol ConfigType: TrackXClientConfig {

    var launchLibraryBaseUrl: String { get }

}
