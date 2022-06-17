//
//  LandpadsEndPoint.swift
//  TrackX
//
//  Created by Oliver Stenning on 01/06/2022.
//

import Foundation

public enum LandpadApi {
    case all
    case one(id:String)
}

extension LandpadApi: EndPointType {
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://api.spacexdata.com/v4/landpads"
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
