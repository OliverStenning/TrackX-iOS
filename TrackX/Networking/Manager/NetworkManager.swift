//
//  NetworkManager.swift
//  TrackX
//
//  Created by Oliver Stenning on 30/05/2022.
//

import Foundation

let PRINT_ERROR = false
let PRINT_RESPONSE = false
let PRINT_JSON = false

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

enum NetworkEnvironment {
    case production
}

struct NetworkManager {
    static let environment : NetworkEnvironment = .production
    private let launchRouter = Router<LaunchEndpoint>()
    private let rocketRouter = Router<RocketEndpoint>()
    private let launchpadRouter = Router<LaunchpadEndpoint>()
    private let landpadRouter = Router<LandpadEndpoint>()
    private let coreRouter = Router<CoreEndpoint>()
    private let capsuleRouter = Router<CapsuleEndpoint>()
    private let payloadRouter = Router<PayloadEndpoint>()
    
    // MARK: - Launch functions
    func getLaunches(completion: @escaping (_ launches: [Launch]?, _ error: String?) -> ()) {
        launchRouter.request(.all, completition: completion)
    }
    
    func getNextLaunch(completion: @escaping (_ launch: Launch?, _ error: String?) -> ()) {
        launchRouter.request(.next, completition: completion)
    }
    
    // MARK: - Rocket functions
    func getRockets(completion: @escaping (_ rockets: [Rocket]?, _ error: String?) -> ()) {
        rocketRouter.request(.all, completition: completion)
    }
    
    // MARK: - Launchpad functions
    func getLaunchpads(completion: @escaping (_ launchpads: [Launchpad]?, _ error: String?) -> ()) {
        launchpadRouter.request(.all, completition: completion)
    }
    
    // MARK: - Landpad functions
    func getLandpads(completion: @escaping (_ landpads: [Landpad]?, _ error: String?) -> ()) {
        landpadRouter.request(.all, completition: completion)
    }
    
    // MARK: - Core functions
    func getCores(completion: @escaping (_ cores: [Core]?, _ error: String?) -> ()) {
        coreRouter.request(.all, completition: completion)
    }
    
    // MARK: - Capsule functions
    func getCapsules(completion: @escaping (_ capsules: [Capsule]?, _ error: String?) -> ()) {
        capsuleRouter.request(.all, completition: completion)
    }
    
    // MARK: - Payload functions
    func getPayloads(completion: @escaping (_ payloads: [Payload]?, _ error: String?) -> ()) {
        payloadRouter.request(.all, completition: completion)
    }
    
}
