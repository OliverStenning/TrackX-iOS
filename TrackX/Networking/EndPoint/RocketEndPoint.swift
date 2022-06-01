//
//  RocketEndPoint.swift
//  TrackX
//
//  Created by Oliver Stenning on 31/05/2022.
//

import Foundation

public enum RocketApi {
    case all
    case one(id:String)
}

extension RocketApi: EndPointType {
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://api.spacexdata.com/v4/rockets/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .all:
            return ""
        case .one(let id):
            return ":\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
