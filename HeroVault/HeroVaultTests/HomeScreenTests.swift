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
    
    //MARK: Tests
    
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
    
    func testCreateImage() {
        let viewModel = HomeScreenViewModel(homeScreenRepository: MockHomeScreenRepository(), delegate: MockViewModelDelegate())
        let marvelData = [Character(id: 1, name: "Iron Man", overview: "Genius billionaire playboy philanthropist", thumbnail: "iron_man.jpg", hasBeenfavourited: false),
            Character(id: 2, name: "Spider-Man", overview: "Friendly neighborhood superhero", thumbnail: "spider_man.jpg", hasBeenfavourited: false)]
        
        viewModel.marvelData = marvelData
        
        let imageUrl = viewModel.createImage(marvelIndex: 0)
        
        XCTAssertEqual(imageUrl, "iron_man.jpg/portrait_incredible.jpg".convertToHttps())
    }
    
    func testFetchCharactersAtIndex() {
        let viewModel = HomeScreenViewModel(homeScreenRepository: MockHomeScreenRepository(), delegate: MockViewModelDelegate())
        let expectedCharacter = Character(id: 1, name: "Iron Man", overview: "Genius billionaire playboy philanthropist", thumbnail: "iron_man.jpg", hasBeenfavourited: false)
        
        viewModel.marvelData = [expectedCharacter]
        
        let characterAtIndex = viewModel.fetchCharacters(atIndex: 0)
        
        XCTAssertEqual(characterAtIndex?.id, expectedCharacter.id)
        XCTAssertEqual(characterAtIndex?.name, expectedCharacter.name)
        XCTAssertEqual(characterAtIndex?.overview, expectedCharacter.overview)
        XCTAssertEqual(characterAtIndex?.thumbnail, expectedCharacter.thumbnail)
        XCTAssertEqual(characterAtIndex?.hasBeenfavourited, expectedCharacter.hasBeenfavourited)
    }
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

class MockViewModelDelegate: ViewModelDelegate {
    var reloadViewCalled = false
    func reloadView() {
        reloadViewCalled = true
    }
}
