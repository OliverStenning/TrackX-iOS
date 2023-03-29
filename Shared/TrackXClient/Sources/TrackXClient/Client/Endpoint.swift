import Foundation

// MARK: - Endpoint

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queries: [URLQueryItem] { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        "https"
    }

    var host: String {
        "t-minus.fly.dev"
    }
}
