//
//  NetworkLogger.swift
//  TrackX
//
//  Created by Oliver Stenning on 02/06/2022.
//

import Foundation

let ENABLE_NETWORK_LOGGING = false

class NetworkLogger {
    
    static func log(request: URLRequest) {
        if ENABLE_NETWORK_LOGGING {
            print("\n- - - - - - - - - - OUTGOING - - - - - - - - - -")
            defer { print("- - - - - - - - - - END - - - - - - - - - -\n") }
            
            let urlAsString = request.url?.absoluteString ?? ""
            let urlComponents = NSURLComponents(string: urlAsString)
            
            let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
            let path = "\(urlComponents?.path ?? "")"
            let query = "\(urlComponents?.query ?? "")"
            let host = "\(urlComponents?.host ?? "")"
            
            var logOutput = """
                            \(urlAsString)
                            \(method) \(path)?\(query) HTTP/1.1
                            HOST: \(host)\n
                            """
            
            for (key, value) in request.allHTTPHeaderFields ?? [:] {
                logOutput += "\(key): \(value)"
            }
            if let body = request.httpBody {
                logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
            }
            
            print(logOutput)
        }
    }
}
