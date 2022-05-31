//
//  EndPointType.swift
//  TrackX
//
//  Created by Oliver Stenning on 30/05/2022.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
