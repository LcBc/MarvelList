//
//  ListViewModelTest.swift
//  MarvelListTests
//
//  Created by Luis Barrios on 25/1/22.
//

import XCTest
@testable import MarvelList

class ListViewModelTest: XCTestCase {
    
    var sut:ListViewModel!
    
    override func setUp() {
        sut = ListViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown()  {
        sut = nil
    }
    
    
    //MARK: initialization
    func testDefaultURLSessionIsShared(){
        XCTAssertEqual(sut.session, URLSession.shared)
    }
    
    func testSetURLSession(){
        let session = URLSession(mockResponder: MarvelCharacter.MockCharacterListDataURLResponder.self)
        sut.session = session
        XCTAssertEqual(sut.session, session)
    }
    
    func testInitialCurrentPage(){
        XCTAssertEqual(sut.currentPage, 0)
    }
    
    func testInitialCharacterListIsEmpty(){
        XCTAssertEqual(sut.characters, [MarvelCharacter]())
    }
    
    
    func testFetchCharacters() throws {
        let session = URLSession(mockResponder: MarvelCharacter.MockCharacterListDataURLResponder.self)
        let characterPublisher = sut.$characters.collect(2).first()
        sut.session = session
        sut.fetchCharacters()
        let result = try awaitCompletion(of: characterPublisher)
        let response = MarvelCharacter.MockCharacterListDataURLResponder.response.data.results
        XCTAssertEqual(result.first?.last, response)
    }
    
    func testPublisherCharactersEqualViewModel() throws{
        let session = URLSession(mockResponder: MarvelCharacter.MockCharacterListDataURLResponder.self)
        let characterPublisher = sut.$characters.collect(2).first()
        sut.session = session
        sut.fetchCharacters()
        let result = try awaitCompletion(of: characterPublisher)
        XCTAssertEqual(result.first?.last, sut.characters)
    }
    
    
    func testMultipleFetchCharacters() throws {
        let session = URLSession(mockResponder: MarvelCharacter.MockCharacterListDataURLResponder.self)
        let characterPublisher = sut.$characters.collect(3).first()
        sut.session = session
        sut.fetchCharacters()
        let session2 = URLSession(mockResponder: MarvelCharacter.MockCharacterListSecondPageDataURLResponder.self)
        sut.session = session2
        sut.fetchCharacters()
        let result = try awaitCompletion(of: characterPublisher)
        var response = MarvelCharacter.MockCharacterListDataURLResponder.response.data.results
        response.append(contentsOf: MarvelCharacter.MockCharacterListSecondPageDataURLResponder.response.data.results)
        XCTAssertEqual(result.first?.last, response)
    }
    
    
    func testLoadingUpdate() throws{
        
        let session = URLSession(mockResponder: MarvelCharacter.MockCharacterListDataURLResponder.self)
        let characterPublisher = sut.$isLoading.collect(2).first()
        sut.session = session
        sut.fetchCharacters()
        _ = try awaitCompletion(of: characterPublisher)
        
        XCTAssertEqual(sut.isLoading, false)
    }
    
    
    
    
}
