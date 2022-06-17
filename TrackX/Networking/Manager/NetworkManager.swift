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
    private let launchRouter = Router<LaunchApi>()
    private let rocketRouter = Router<RocketApi>()
    private let launchpadRouter = Router<LaunchpadApi>()
    private let landpadRouter = Router<LandpadApi>()
    private let coreRouter = Router<CoreApi>()
    private let capsuleRouter = Router<CapsuleApi>()
    private let payloadRouter = Router<PayloadApi>()
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func handleResponse<T: Decodable>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (_ launches: T?, _ error: String?) -> ()) {
        if error != nil {
            completion(nil, "Please check your network connection.")
        }
        
        if let response = response as? HTTPURLResponse {
            let result = self.handleNetworkResponse(response)
            switch result {
            case .success:
                guard let responseData = data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                do {
                    if PRINT_RESPONSE {
                        print(responseData)
                    }
                    if PRINT_JSON {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                    }
                    let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                    completion(apiResponse, nil)
                } catch {
                    if PRINT_ERROR {
                        print(error)
                    }
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                completion(nil, networkFailureError)
            }
        }
    }
    
    // MARK: - Launch functions
    func getLaunches(completion: @escaping (_ launches: [Launch]?, _ error: String?) -> ()) {
        launchRouter.request(.all) { data, response, error in
            handleResponse(data, response, error, completion: completion)
        }
    }
    
    func getNextLaunch(completion: @escaping (_ launch: Launch?, _ error: String?) -> ()) {
        launchRouter.request(.next) { data, response, error in
            handleResponse(data, response, error, completion: completion)
        }
    }
    
    // MARK: - Rocket functions
    func getRockets(completion: @escaping (_ rockets: [Rocket]?, _ error: String?) -> ()) {
        rocketRouter.request(.all) { data, response, error in
            handleResponse(data, response, error, completion: completion)
        }
    }
    
    // MARK: - Launchpad functions
    func getLaunchpads(completion: @escaping (_ launchpads: [Launchpad]?, _ error: String?) -> ()) {
        launchpadRouter.request(.all) { data, response, error in
            handleResponse(data, response, error, completion: completion)
        }
    }
    
    // MARK: - Landpad functions
    func getLandpads(completion: @escaping (_ landpads: [Landpad]?, _ error: String?) -> ()) {
        landpadRouter.request(.all) { data, response, error in
            handleResponse(data, response, error, completion: completion)
        }
    }
    
    // MARK: - Core functions
    func getCores(completion: @escaping (_ cores: [Core]?, _ error: String?) -> ()) {
        coreRouter.request(.all) { data, response, error in
            handleResponse(data, response, error, completion: completion)
        }
    }
    
    // MARK: - Capsule functions
    func getCapsules(completion: @escaping (_ capsules: [Capsule]?, _ error: String?) -> ()) {
        capsuleRouter.request(.all) { data, response, error in
            handleResponse(data, response, error, completion: completion)
        }
    }
    
    // MARK: - Payload functions
    func getPayloads(completion: @escaping (_ payloads: [Payload]?, _ error: String?) -> ()) {
        payloadRouter.request(.all) { data, response, error in
            handleResponse(data, response, error, completion: completion)
        }
    }
    
}
