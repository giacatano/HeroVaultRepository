//
//  HomeScreenTests.swift
//  HeroVaultTests
//
//  Created by Gia Catano on 2024/05/06.
//

import XCTest
@testable import HeroVault

class HomeScreenTests: XCTestCase {
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
        let characterResponse = CharacterResponse(data:
                                                    CharacterData(results: [Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man.jpg")]))
        
        mockRepository.characterResponseToReturn = .success(characterResponse)
        viewModel.set(marvelDataType: .character)
        viewModel.fetchMarvelData()
        XCTAssertEqual(viewModel.marvelDataCount, 1)
        
        XCTAssertEqual(viewModel.fetchMarvelData(atIndex: 0)?.name, "Iron Man")
        XCTAssertEqual(viewModel.fetchMarvelData(atIndex: 0)?.overview, "Genius billionaire playboy philanthropist")
        XCTAssertEqual(viewModel.fetchMarvelData(atIndex: 0)?.thumbnail, "iron_man.jpg")
    }
    
    func testFetchCharactersFailure() {
        let characterResponse = NetworkingError.parsingError
        mockRepository.characterResponseToReturn = .failure(characterResponse)
        viewModel.fetchMarvelData()
        XCTAssertFalse(mockDelegate.reloadViewCalled)
        mockDelegate.stopLoadingIndicator()
        XCTAssertTrue(mockDelegate.isCalled)
    }
    
    func testFetchComicsSuccess() {
        let comicResponse = ComicResponse(data: ComicData(results: [Comic(id: 1,
                                                                          name: "Iron Man",
                                                                          overview: "Genius billionaire playboy philanthropist",
                                                                          thumbnail: "iron_man.jpg")]))
        
        viewModel.set(marvelDataType: .comic)
        mockRepository.comicResponseToReturn = .success(comicResponse)
        viewModel.fetchMarvelData()
        XCTAssertEqual(viewModel.marvelDataCount, 1)
        XCTAssertEqual(viewModel.fetchMarvelData(atIndex: 0)?.name, "Iron Man")
        XCTAssertEqual(viewModel.fetchMarvelData(atIndex: 0)?.overview, "Genius billionaire playboy philanthropist")
        XCTAssertEqual(viewModel.fetchMarvelData(atIndex: 0)?.thumbnail, "iron_man.jpg")
        XCTAssertTrue(mockDelegate.reloadViewCalled)
    }
    
    func testFetchComicsFailure() {
        let comicResponse = NetworkingError.parsingError
        mockRepository.comicResponseToReturn = .failure(comicResponse)
        viewModel.fetchMarvelData()
        XCTAssertFalse(mockDelegate.reloadViewCalled)
        mockDelegate.stopLoadingIndicator()
        XCTAssertTrue(mockDelegate.isCalled)
    }
    
    func testFilteredMarvelDataCount() {
        let characterResponse = CharacterResponse(data:
                                                    CharacterData(results: [Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man"),
                                                                            Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man")]))
        
        mockRepository.characterResponseToReturn = .success(characterResponse)
        viewModel.set(marvelDataType: .character)
        viewModel.fetchMarvelData()
        XCTAssertEqual(viewModel.marvelDataCount, 2)
    }
    
    func testFetchMarvelNameAndImage() {
        let characterResponse = CharacterResponse(data:
                                                    CharacterData(results: [Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man")]))
        
        mockRepository.characterResponseToReturn = .success(characterResponse)
        viewModel.set(marvelDataType: .character)
        viewModel.fetchMarvelData()
        
        viewModel.isSearching = false
        viewModel.filterMarvelData(filteredText: "")
        let (name1, image1) = viewModel.fetchMarvelNameAndImage(for: 0)
        XCTAssertEqual(name1, "Iron Man")
        XCTAssertEqual(image1, "iron_man/portrait_incredible.jpg")
        
        viewModel.isSearching = true
        viewModel.fetchMarvelData()
        viewModel.filterMarvelData(filteredText: "")
        
        let (name2, image2) = viewModel.fetchMarvelNameAndImage(for: 0)
        XCTAssertEqual(name2, "Iron Man")
        XCTAssertEqual(image2, "iron_man/portrait_incredible.jpg")
    }
    
    func testNumberOfSectionsForNotFiltering() {
        let characterResponse = CharacterResponse(data:
                                                    CharacterData(results: [Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man")]))
        
        mockRepository.characterResponseToReturn = .success(characterResponse)
        viewModel.set(marvelDataType: .character)
        viewModel.fetchMarvelData()
        viewModel.isSearching = false
        XCTAssertEqual(viewModel.numberOfSections, 1)
    }
    
    func testNumberOfSectionsForFiltering() {
        let characterResponse = CharacterResponse(data:
                                                    CharacterData(results: [Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man")]))
        
        mockRepository.characterResponseToReturn = .success(characterResponse)
        viewModel.set(marvelDataType: .character)
        viewModel.fetchMarvelData()
        viewModel.isSearching = true
        viewModel.filterMarvelData(filteredText: "")
        XCTAssertEqual(viewModel.numberOfSections, 1)
    }
    
    func testHandleSegmentedControlForCharactersSelected() {
        viewModel.handleSegmentedControl(segmentedControlTitle: "Characters")
        let characterResponse = CharacterResponse(data:
                                                    CharacterData(results: [Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man"),
                                                                            Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man")]))
        
        mockRepository.characterResponseToReturn = .success(characterResponse)
        viewModel.set(marvelDataType: .character)
        viewModel.fetchMarvelData()
        XCTAssertEqual(viewModel.numberOfSections, 2)
    }
    
    func testHandleSegmentedControlForComicsSelected() {
        viewModel.handleSegmentedControl(segmentedControlTitle: "Characters")
        let comicResponse = ComicResponse(data:
                                              ComicData(results: [Comic(id: 1,
                                                                        name: "Iron Man",
                                                                        overview: "Genius billionaire playboy philanthropist",
                                                                        thumbnail: "iron_man")]))
        
        mockRepository.comicResponseToReturn = .success(comicResponse)
        viewModel.fetchMarvelData()
        XCTAssertNotEqual(viewModel.numberOfSections, 1)
    }
    
    func testFilteredMarvelDataWithSearchText() {
        let characterResponse = CharacterResponse(data:
                                                    CharacterData(results: [Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man"),
                                                                            Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man")]))
        
        mockRepository.characterResponseToReturn = .success(characterResponse)
        viewModel.set(marvelDataType: .character)
        viewModel.fetchMarvelData()
        viewModel.filterMarvelData(filteredText: "Iron Man")
        XCTAssertTrue(viewModel.isSearching)
        XCTAssertTrue(mockDelegate.reloadViewCalled)
    }
    
    func testFilteredMarvelDataWithNoSearchText() {
        let characterResponse = CharacterResponse(data:
                                                    CharacterData(results: [Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man"),
                                                                            Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man")]))
        
        mockRepository.characterResponseToReturn = .success(characterResponse)
        viewModel.set(marvelDataType: .character)
        viewModel.fetchMarvelData()
        viewModel.filterMarvelData(filteredText: "")
        XCTAssertFalse(viewModel.isSearching)
    }
    
    func testFetchMarvelDataAtIndexWhenNotFiltering() {
        let characterResponse = CharacterResponse(data:
                                                    CharacterData(results: [Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man"),
                                                                            Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man")]))
        
        mockRepository.characterResponseToReturn = .success(characterResponse)
        viewModel.set(marvelDataType: .character)
        viewModel.fetchMarvelData()
        XCTAssertEqual(viewModel.fetchMarvelData(atIndex: 0)?.name, "Iron Man")
    }
    
    func testFetchMarvelDataAtIndexWhenFiltering() {
        let characterResponse = CharacterResponse(data:
                                                    CharacterData(results: [Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man"),
                                                                            Character(id: 1,
                                                                                      name: "spider Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man")]))
        
        mockRepository.characterResponseToReturn = .success(characterResponse)
        viewModel.set(marvelDataType: .character)
        viewModel.fetchMarvelData()
        viewModel.filterMarvelData(filteredText: "Ir")
        XCTAssertEqual(viewModel.fetchMarvelData(atIndex: 0)?.name, "Iron Man")
        XCTAssertEqual(viewModel.filteredMarvelDataCount, 1)
    }
    
    func testFilterMarvelDataEmptyFilteredMarvelData() {
        let characterResponse = CharacterResponse(data:
                                                    CharacterData(results: [Character(id: 1,
                                                                                      name: "Spider",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man")]))
        
        mockRepository.characterResponseToReturn = .success(characterResponse)
        viewModel.set(marvelDataType: .character)
        viewModel.fetchMarvelData()
        viewModel.filterMarvelData(filteredText: "")
        XCTAssertTrue(viewModel.hideNoResultsText)
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

class MockViewModelProtocol: ViewModelProtocol {
    var isCalled = false
    
    func startLoadingIndicator() {
        isCalled = true
    }
    
    func stopLoadingIndicator() {
        isCalled = true
    }
    
    var reloadViewCalled = false
    
    func reloadView() {
        reloadViewCalled = true
    }
}
