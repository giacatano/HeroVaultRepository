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
    var mockDelegate: MockViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockHomeScreenRepository()
        mockDelegate = MockViewModelDelegate()
        viewModel = HomeScreenViewModel(homeScreenRepository: mockRepository, delegate: mockDelegate)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockDelegate = nil
        super.tearDown()
    }
    
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
    
//    func testFetchCharactersFailure() {
//        // Given
//        //let error = NetworkingError.invalidResponse
//        mockRepository.characterResponseToReturn = .failure(error)
//        // When
//        viewModel.fetchMarvelData()
//        // Then
//        XCTAssertEqual(viewModel.marvelDataCount, 0)
//        XCTAssertEqual(viewModel.error as? NetworkingError, error)
//        XCTAssertFalse(mockDelegate.reloadViewCalled)
//    }
    // Similarly, write tests for fetchComics, createImage, fetchCharacters(atIndex:), and checkIfImageIsAvailable methods.
}
// Mock Classes
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

class MockViewModelDelegate: ViewModelDelegate {
    var reloadViewCalled = false
    func reloadView() {
        reloadViewCalled = true
    }
}
