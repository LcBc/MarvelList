//
//  MarvelCharacter + Extension.swift
//  MarvelListTests
//
//  Created by Luis Barrios on 24/1/22.
//

import Foundation
@testable import MarvelList


extension MarvelCharacter {
    enum MockCharacterListDataURLResponder: MockURLResponder {
        static var response: NetworkResponse<CharacterResponseData> {
            get {
                let data = try! Data.fromJSON(fileName: "ListFirstPage")
                let decoder = JSONDecoder()
                return try! decoder.decode(NetworkResponse<CharacterResponseData>.self, from: data)
            }
        }
        static func respond(to request: URLRequest) throws -> Data {
            return try JSONEncoder().encode(response)
        }
    }
    
    enum MockCharacterListSecondPageDataURLResponder: MockURLResponder {
        static var response: NetworkResponse<CharacterResponseData> {
            get {
                let data = try! Data.fromJSON(fileName: "ListSecondPage")
                let decoder = JSONDecoder()
                return try! decoder.decode(NetworkResponse<CharacterResponseData>.self, from: data)
            }
        }
        static func respond(to request: URLRequest) throws -> Data {
            return try JSONEncoder().encode(response)
        }
    }
    
    enum MockCharacterListLastPageDataURLResponder: MockURLResponder {
        static var response: NetworkResponse<CharacterResponseData> {
            get {
                let data = try! Data.fromJSON(fileName: "LastListPage")
                let decoder = JSONDecoder()
                return try! decoder.decode(NetworkResponse<CharacterResponseData>.self, from: data)
            }
        }
        static func respond(to request: URLRequest) throws -> Data {
            return try JSONEncoder().encode(response)
        }
    }
    
    
}

enum MockErrorURLResponder: MockURLResponder {
    static func respond(to request: URLRequest) throws -> Data {
        throw URLError(.badServerResponse)
    }
}
