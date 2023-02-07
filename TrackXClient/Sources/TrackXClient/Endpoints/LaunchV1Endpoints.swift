import Foundation

enum LaunchEndpointV1 {
    case latest
    case next
}

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
        return [URLQueryItem(name: "provider", value: "spacex")]
    }
    
    var method: HTTPMethod {
        switch self {
            case .latest, .next:
                return .get
        }
    }
    
    var header: [String: String]? {
        return nil
    }
    
    var body: [String: String]? {
        return nil
    }
    
    
    
}
