import Foundation

// MARK: - LaunchEndpoints

enum LaunchEndpoints {
    case latest
    case upcoming
}

// MARK: Endpoint

extension LaunchEndpoints: Endpoint {

    var host: String {
        TrackXClientConfiguration.shared.launchLibraryBaseUrl
    }

    var path: String {
        switch self {
        case .latest:
            return "/2.2.0/launch/previous"
        case .upcoming:
            return "/2.2.0/launch/upcoming"
        }
    }

    var queries: [URLQueryItem] {
        [
            URLQueryItem(name: "search", value: "spacex"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "limit", value: "3"),
            URLQueryItem(name: "offset", value: "0")
//            URLQueryItem(name: "mode", value: "detailed")
        ]
    }

    var method: HTTPMethod {
        switch self {
        case .latest, .upcoming:
            return .get
        }
    }

    var header: [String: String]? {
        nil
    }

    var body: [String: String]? {
        nil
    }

}
