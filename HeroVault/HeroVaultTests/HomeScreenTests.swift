//
//  HomeScreenTests.swift
//  HeroVaultTests
//
//  Created by Gia Catano on 2024/05/06.
//

import XCTest
@testable import HeroVault

class HomeScreenViewModelTests: XCTestCase {
    var viewModel: HomeScreenViewModel!
    var mockRepository: MockHomeScreenRepository!
    var mockDelegate: MockViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockHomeScreenRepository()
        mockDelegate = MockViewModelProtocol()
        viewModel = HomeScreenViewModel(homeScreenRepository: mockRepository, delegate: mockDelegate)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testFetchCharactersSuccess() {
        let characterResponse = CharacterResponse(data: CharacterData(results: [Character(id: 1, name: "Iron Man", overview: "Genius billionaire playboy philanthropist", thumbnail: "iron_man.jpg", hasBeenfavourited: false)]))
        
        mockRepository.characterResponseToReturn = .success(characterResponse)
        viewModel.fetchMarvelData()
        
        XCTAssertEqual(viewModel.marvelDataCount, 1)
        XCTAssertEqual(viewModel.marvelData[0].name, "Iron Man")
        XCTAssertEqual(viewModel.marvelData[0].overview, "Genius billionaire playboy philanthropist")
        XCTAssertEqual(viewModel.marvelData[0].thumbnail, "iron_man.jpg")
        XCTAssertNil(viewModel.error)
        XCTAssertTrue(mockDelegate.reloadViewCalled)
    }
    
    func testFetchCharactersFailure() {
        let characterResponse = NetworkingError.parsingError
        mockRepository.characterResponseToReturn = .failure(characterResponse)
        
        viewModel.fetchMarvelData()
        guard let networkingError = viewModel.error as? NetworkingError else {
            return
        }
        
        XCTAssertEqual(networkingError, NetworkingError.parsingError)
    }
    
    func testFetchComicsSuccess() {
        let comicResponse = ComicResponse(data: ComicData(results: [Comic(id: 1, name: "Iron Man", overview: "Genius billionaire playboy philanthropist", thumbnail: "iron_man.jpg", hasBeenfavourited: false)]))
        
        viewModel.set(marvelDataType: .comic)
        mockRepository.comicResponseToReturn = .success(comicResponse)
        viewModel.fetchMarvelData()
        
        XCTAssertEqual(viewModel.marvelDataCount, 1)
        XCTAssertEqual(viewModel.marvelData[0].name, "Iron Man")
        XCTAssertEqual(viewModel.marvelData[0].overview, "Genius billionaire playboy philanthropist")
        XCTAssertEqual(viewModel.marvelData[0].thumbnail, "iron_man.jpg")
        XCTAssertNil(viewModel.error)
        XCTAssertTrue(mockDelegate.reloadViewCalled)
    }
    
    func testFetchComicsFailure() {
        let comicResponse = NetworkingError.parsingError
        mockRepository.comicResponseToReturn = .failure(comicResponse)
        
        viewModel.set(marvelDataType: .comic)
        viewModel.fetchMarvelData()
        
        guard let networkingError = viewModel.error as? NetworkingError else {
            return
        }
        
        XCTAssertEqual(networkingError, NetworkingError.parsingError)
    }
    
    func testCreateImage() {
        let viewModel = HomeScreenViewModel(homeScreenRepository: MockHomeScreenRepository(), delegate: MockViewModelProtocol())
        let marvelData = [Character(id: 1, name: "Iron Man",
                                    overview: "Genius billionaire playboy philanthropist",
                                    thumbnail: "iron_man.jpg", hasBeenfavourited: false),
                          Character(id: 2, name: "Spider-Man", overview: "Friendly neighborhood superhero", thumbnail: "spider_man.jpg", hasBeenfavourited: false)]
        
        viewModel.marvelData = marvelData
        //let imageUrl = viewModel.createImage(marvelIndex: 0)
        
      //  XCTAssertEqual(imageUrl, "iron_man.jpg/portrait_incredible.jpg".convertToHttps())
    }
    
    
    func testFetchMarvelNameAndImage() {
            // Setup
            let marvelIndex = 0
            let expectedName = "Iron Man"
            let expectedImage = "https://example.com/iron_man.jpg/portrait_incredible.jpg"
            
            // When not searching
            viewModel.isSearching = false
            let (nameNotSearching, imageNotSearching) = viewModel.fetchMarvelNameAndImage(for: marvelIndex)
            
            XCTAssertEqual(nameNotSearching, expectedName)
            XCTAssertEqual(imageNotSearching, expectedImage)
            
            // When searching
            viewModel.isSearching = true
            let (nameSearching, imageSearching) = viewModel.fetchMarvelNameAndImage(for: marvelIndex)
            
            XCTAssertEqual(nameSearching, expectedName)
            XCTAssertEqual(imageSearching, expectedImage)
        }
    
//    func testFetchCharactersAtIndex() {
//        let viewModel = HomeScreenViewModel(homeScreenRepository: MockHomeScreenRepository(), delegate: MockViewModelProtocol())
//        let expectedCharacter = Character(id: 1, name: "Iron Man",
//                                          overview: "Genius billionaire playboy philanthropist",
//                                          thumbnail: "iron_man.jpg", hasBeenfavourited: false)
//        
//        viewModel.marvelData = [expectedCharacter]
//        let characterAtIndex = viewModel.fetchCharacters(atIndex: 0)
//        
//        XCTAssertEqual(characterAtIndex?.id, expectedCharacter.id)
//        XCTAssertEqual(characterAtIndex?.name, expectedCharacter.name)
//        XCTAssertEqual(characterAtIndex?.overview, expectedCharacter.overview)
//        XCTAssertEqual(characterAtIndex?.thumbnail, expectedCharacter.thumbnail)
//        XCTAssertEqual(characterAtIndex?.hasBeenfavourited, expectedCharacter.hasBeenfavourited)
//    }
}

// MARK: Mock Classes

class MockHomeScreenRepository: HomeScreenRepositoryType {
    var characterResponseToReturn: CharacterResult?
    var comicResponseToReturn: ComicResult?
    
    func fetchCharacters(completion: @escaping (CharacterResult) -> Void) {
        if let characterResponse = characterResponseToReturn {
            completion(characterResponse)
        }
    }
    
    func fetchComics(completion: @escaping (ComicResult) -> Void) {
        if let comicResponse = comicResponseToReturn {
            completion(comicResponse)
        }
    }
}

class MockViewModelProtocol: ViewModelProtocol {
    var reloadViewCalled = false
    
    func reloadView() {
        reloadViewCalled = true
    }
}
