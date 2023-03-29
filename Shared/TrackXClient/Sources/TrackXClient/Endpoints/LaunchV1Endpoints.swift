import Foundation

// MARK: - LaunchEndpointV1

enum LaunchEndpointV1 {
    case latest
    case next
}

// MARK: Endpoint

extension LaunchEndpointV1: Endpoint {
    var path: String {
        switch self {
        case .latest:
            return "/launch/v1/latest"
        case .next:
            return "/launch/v1/next"
        }
    }

    var queries: [URLQueryItem] {
        [URLQueryItem(name: "provider", value: "spacex")]
    }

    var method: HTTPMethod {
        switch self {
        case .latest, .next:
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
