//
//  NetworkRouter.swift
//  TrackX
//
//  Created by Oliver Stenning on 30/05/2022.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completition: @escaping NetworkRouterCompletion)
    func cancel()
}
