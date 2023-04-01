import Foundation

// MARK: - TrackXClientConfig

public protocol TrackXClientConfig {
    var launchLibraryBaseUrl: String { get }
}

// MARK: - TrackXClientConfiguration

final class TrackXClientConfiguration {

    // MARK: Lifecycle

    private init() {
        guard let config = TrackXClientConfiguration.config else {
            fatalError("TrackX Client Config Error - You must call setup before accessing TrackXClientConfiguration.shared")
        }

        launchLibraryBaseUrl = config.launchLibraryBaseUrl
        print("Set base url as: \(launchLibraryBaseUrl)")
    }

    // MARK: Public

    public static let shared = TrackXClientConfiguration()

    public class func setup(_ config: TrackXClientConfig) {
        TrackXClientConfiguration.config = config
    }

    // MARK: Internal

    let launchLibraryBaseUrl: String

    // MARK: Private

    private static var config: TrackXClientConfig?
}

public func setup(with config: TrackXClientConfig) {
    TrackXClientConfiguration.setup(config)
}
