//
//  LaunchEndpoint.swift
//  TrackX
//
//  Created by Oliver Stenning on 17/06/2022.
//

import Foundation

public enum LaunchEndpoint {
    case all
    case one(id:String)
    case latest
    case past
    case next
    case upcoming
}

extension LaunchEndpoint: EndPointType {
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://api.spacexdata.com/v5/launches/"
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
        case .latest:
            return "latest"
        case .past:
            return "past"
        case .next:
            return "next"
        case .upcoming:
            return "upcoming"
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
