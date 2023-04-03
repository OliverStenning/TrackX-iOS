import Foundation

// MARK: - Environment

enum Environment: String {
    case debugDevelopment = "Debug Development"
    case releaseDevelopment = "Release Development"

    case debugProduction = "Debug Production"
    case releaseProduction = "Release Production"
}

// MARK: - BuildConfiguration

class BuildConfiguration {

    // MARK: Lifecycle

    init() {
        guard let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String else {
            environment = .debugDevelopment
            return
        }
        environment = Environment(rawValue: currentConfiguration) ?? .debugDevelopment
    }

    // MARK: Internal

    static let shared = BuildConfiguration()

    var environment: Environment

    var config: ConfigType {
        switch environment {
        case .debugDevelopment, .releaseDevelopment:
            return ConfigDevelopment()
        case .debugProduction, .releaseProduction:
            return ConfigProduction()
        }
    }

}
