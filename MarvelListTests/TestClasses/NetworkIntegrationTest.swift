//
//  NetworkIntegrationTest.swift
//  MarvelListTests
//
//  Created by Luis Barrios on 24/1/22.
//

import XCTest
@testable import MarvelList


class NetworkIntegrationTests: XCTestCase {
    
    func testSuccessfullFetchingCharacterRequest() throws {
        
        let session = URLSession(mockResponder: MarvelCharacter.MockCharacterListDataURLResponder.self)
        let publisher = session.publisher(for: .CharacterList(auth: AuthenticationModel()), using: ())
        let result = try awaitCompletion(of: publisher)
        let response = MarvelCharacter.MockCharacterListDataURLResponder.response.data
        XCTAssertEqual(result, [response])

    }
    
    func testSuccessfullFetchingPage2CharacterRequest() throws {
        
        let session = URLSession(mockResponder: MarvelCharacter.MockCharacterListSecondPageDataURLResponder.self)
        let publisher = session.publisher(for: .CharacterList(auth: AuthenticationModel()), using: ())
        let result = try awaitCompletion(of: publisher)
        let response = MarvelCharacter.MockCharacterListDataURLResponder.response.data
        XCTAssertEqual(result, [response])

    }
    
    func testFailingWhenEncounteringError() throws {
           let session = URLSession(mockResponder: MockErrorURLResponder.self)
           let publisher = session.publisher(for: .CharacterList(auth: AuthenticationModel()), using: ())
           XCTAssertThrowsError(try awaitCompletion(of: publisher))
       }
    
    
    

    
}
