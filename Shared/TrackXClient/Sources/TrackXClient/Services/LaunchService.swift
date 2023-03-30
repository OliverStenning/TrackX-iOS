import Foundation

// MARK: - LaunchServiceProtocol

public protocol LaunchServiceProtocol {
    func getUpcoming() async throws -> [Launch]
    func getLatest() async throws -> [Launch]
}

// MARK: - LaunchService

public struct LaunchService: HTTPClient, LaunchServiceProtocol {

    // MARK: Lifecycle

    public init() {}

    // MARK: Public

    public func getUpcoming() async throws -> [Launch] {
        try await sendRequest(endpoint: LaunchEndpoints.upcoming, responseModel: TCLaunchResponse.self).results.map { Launch(from: $0) }
    }

    public func getLatest() async throws -> [Launch] {
        try await sendRequest(endpoint: LaunchEndpoints.latest, responseModel: TCLaunchResponse.self).results.map { Launch(from: $0) }
    }

}
