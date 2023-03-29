import Foundation

// MARK: - LaunchServiceProtocol

public protocol LaunchServiceProtocol {
    func getLatestLaunch() async throws -> LaunchModel
    func getNextLaunch() async throws -> LaunchModel
}

// MARK: - LaunchService

public struct LaunchService: HTTPClient, LaunchServiceProtocol {

    // MARK: Lifecycle

    public init() {}

    // MARK: Public

    public func getLatestLaunch() async throws -> LaunchModel {
        try await LaunchModel(from: sendRequest(endpoint: LaunchEndpointV1.latest, responseModel: LaunchV1.self))
    }

    public func getNextLaunch() async throws -> LaunchModel {
        try await LaunchModel(from: sendRequest(endpoint: LaunchEndpointV1.next, responseModel: LaunchV1.self))
    }
}
