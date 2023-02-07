import Foundation

public protocol LaunchServiceProtocol {
    func getLatestLaunch() async throws -> LaunchModel
    func getNextLaunch() async throws -> LaunchModel
}

public struct LaunchService: HTTPClient, LaunchServiceProtocol {
    
    public init() {}
    
    public func getLatestLaunch() async throws -> LaunchModel {
        return LaunchModel(from: try await sendRequest(endpoint: LaunchEndpointV1.latest, responseModel: LaunchV1.self))
    }
    
    public func getNextLaunch() async throws -> LaunchModel  {
        return LaunchModel(from: try await sendRequest(endpoint: LaunchEndpointV1.next, responseModel: LaunchV1.self))
    }
    
}
