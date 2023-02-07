import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
}

extension HTTPClient {
    
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queries
        
        guard let url = urlComponents.url else {
//            return .failure(.invalidURL)
            throw RequestError.invalidURL
        }
        
        print(url.absoluteString)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
//                return .failure(.noResponse)
                throw RequestError.noResponse
            }
            
            switch response.statusCode {
                case 200...299:
                    guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
//                        return .failure(.decode)
                        throw RequestError.decode
                    }
//                    return .success(decodedResponse)
                    return decodedResponse
                case 401:
//                    return .failure(.unauthorized)
                    throw RequestError.unauthorized
                default:
//                    return .failure(.unexpectedStatusCode)
                    throw RequestError.unexpectedStatusCode
            }
        } catch {
//            return .failure(.unknown)
            throw RequestError.unknown
        }
        
    }
    
}
