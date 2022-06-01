//
//  ParameterEncoding.swift
//  TrackX
//
//  Created by Oliver Stenning on 30/05/2022.
//

import Foundation

public typealias Parameters = [String:Any]

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
