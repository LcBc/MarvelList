//
//  EndpointTests.swift
//  MarvelListTests
//
//  Created by Luis Barrios on 23/1/22.
//

import XCTest
@testable import MarvelList

class EndpointTests: XCTestCase {
    
    var auth:AuthenticationModel!
    typealias StubbedEndpoint = Endpoint<EndpointKinds.Stub, String>
    let host = URLHost(rawValue: "test")
    
    override func setUp(){
        self.auth = AuthenticationModel(apikey: "c426594a1689cb226a137dd9805bd8a2", privatekey: "f02611c37164c0dd49d2c416b4369db6909da6d5", ts: "1642774381")
    }
    
    override func tearDown() {
        self.auth = nil
    }
    
    
    
    func testCharacterListRequestGeneration() throws {
        let expectedResult = URL(string: "https://gateway.marvel.com:443/v1/public/characters?apikey=c426594a1689cb226a137dd9805bd8a2&hash=8b73ba04b2ef7156d8eb3dd325cba91e&ts=1642774381")
        let endpoint = StubbedEndpoint(path: "characters", queryItems: auth.queryItems)
        let request = try XCTUnwrap(endpoint.makeRequest(with: ()))
        XCTAssertEqual(request.url, expectedResult)
    }
    
    func testCreateCharacterURLGeneration(){
        let expectedResult = URL(string: "https://gateway.marvel.com:443/v1/public/characters/1011334?apikey=c426594a1689cb226a137dd9805bd8a2&hash=8b73ba04b2ef7156d8eb3dd325cba91e&ts=1642774381")
        XCTAssertEqual(expectedResult, Endpoint.Character(withID: 1011334,auth: auth).url())
    }
    
    func testCreateCharacterRequestGeneration() throws{
        let expectedResult = URL(string: "https://gateway.marvel.com:443/v1/public/characters/1011334?apikey=c426594a1689cb226a137dd9805bd8a2&hash=8b73ba04b2ef7156d8eb3dd325cba91e&ts=1642774381")
        
        
        let endpoint = StubbedEndpoint(path: "characters/1011334", queryItems: auth.queryItems)
        let request =  try XCTUnwrap(endpoint.makeRequest(with: ()))
        XCTAssertEqual(request.url, expectedResult)
    }
    
    
    
    func testCreateCharacterListWithOffsetURLGeneration(){
        let expectedResult = URL(string: "https://gateway.marvel.com:443/v1/public/characters?offset=1&apikey=c426594a1689cb226a137dd9805bd8a2&hash=8b73ba04b2ef7156d8eb3dd325cba91e&ts=1642774381")
        XCTAssertEqual(expectedResult, Endpoint.CharacterList(offset: 1,auth: auth).url())
    }
    
    func CreateCharacterListWithOffsetRequestGeneration() throws{
        let expectedResult = URL(string: "https://gateway.marvel.com:443/v1/public/characters?offset=1&apikey=c426594a1689cb226a137dd9805bd8a2&hash=8b73ba04b2ef7156d8eb3dd325cba91e&ts=1642774381")
        var queryItems = [URLQueryItem(name: "offset",value: "1")]
        queryItems.append(contentsOf: auth.queryItems)
        
        let endpoint = StubbedEndpoint(path: "characters", queryItems: queryItems)
        let request = try XCTUnwrap(endpoint.makeRequest(with: ()))
        XCTAssertEqual(request.url, expectedResult)
    }
    
    
    
    
    
}
