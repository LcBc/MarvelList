//
//  Endpoint.swift
//  MarvelList
//
//  Created by Luis Barrios on 22/1/22.
//

import Foundation

protocol EndpointKind {
    associatedtype RequestData
    
    static func prepare(_ request: inout URLRequest,
                        with data: RequestData)
}


enum EndpointKinds {
    enum Public: EndpointKind {
        static func prepare(_ request: inout URLRequest,
                            with _: Void) {
            // Here we can do things like assign a custom cache
            // policy for loading our publicly available data.
            // In this example we're telling URLSession not to
            // use any locally cached data for these requests:
            request.cachePolicy = .reloadIgnoringLocalCacheData
        }
    }
}


struct Endpoint<Kind: EndpointKind, Response: Codable> {
    var path: String
    var queryItems = [URLQueryItem]()
    
}


extension Endpoint {
    func url(host: URLHost = .default)-> URL{
        var components = URLComponents()
        components.scheme = "https"
        components.host = host.rawValue
        components.port = 443
        components.path = "/v1/public/" + path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        
        return url
    }
    
    func makeRequest(with data: Kind.RequestData,host: URLHost = .default) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host.rawValue
        components.port = 443
        components.path = "/v1/public/" + path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        
        // If either the path or the query items passed contained
        // invalid characters, we'll get a nil URL back:
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        Kind.prepare(&request, with: data)
        return request
    }
    
}






enum EndpointErrors: Error {
    case InvalidEndpointError
}


extension Endpoint where Kind == EndpointKinds.Public, Response == CharacterResponseData {
    
    
    static func Character(withID id: Int, auth: AuthenticationModel) -> Endpoint {
        Endpoint(path: "characters/\(id)",queryItems: auth.queryItems)
    }
    
    static func CharacterList(
        offset:Int = 0, auth:AuthenticationModel) -> Endpoint {
            
            var queryItems = [URLQueryItem(name: "offset",value: String(offset)
                                          )]
            
            queryItems.append(contentsOf: auth.queryItems)
            return Endpoint(
                path: "characters",
                queryItems:queryItems
            )
        }
}
