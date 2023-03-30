import Foundation

// MARK: - LaunchServiceProtocol

public protocol LaunchServiceProtocol {
    func getUpcoming() async throws -> [TCLaunch]
    func getLatest() async throws -> [TCLaunch]
}

// MARK: - LaunchService

public struct LaunchService: HTTPClient, LaunchServiceProtocol {

    // MARK: Lifecycle

    public init() {}

    // MARK: Public
    
    public func getUpcoming() async throws -> [TCLaunch] {
        try await sendRequest(endpoint: LaunchEndpoints.upcoming, responseModel: TCLaunchResponse.self).results
    }

    public func getLatest() async throws -> [TCLaunch] {
        try await sendRequest(endpoint: LaunchEndpoints.latest, responseModel: TCLaunchResponse.self).results
    }

}
