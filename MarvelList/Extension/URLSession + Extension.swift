//
//  URLSession + Extension.swift
//  MarvelList
//
//  Created by Luis Barrios on 22/1/22.
//

import Foundation
import Combine


extension URLSession {
    func publisher<T: Codable>(
        for url: URL,
        responseType: T.Type = T.self,
        decoder: JSONDecoder = .init()
    ) -> AnyPublisher<T, Error> {
        
        dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NetworkResponse<T>.self, decoder: decoder)
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
    
    
    func publisher<K, R>(
        for endpoint: Endpoint<K, R>,
        using requestData: K.RequestData,
        decoder: JSONDecoder = .init()
    ) -> AnyPublisher<R, Error> {
        guard let request = endpoint.makeRequest(with: requestData) else {
            return Fail(
                error: EndpointErrors.InvalidEndpointError
            ).eraseToAnyPublisher()
        }
       
        return dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: NetworkResponse<R>.self, decoder: decoder)
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
    
}
