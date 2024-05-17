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
        let characterResponse = CharacterResponse(data:
                                                    CharacterData(results: [Character(id: 1,
                                                                                      name: "Iron Man",
                                                                                      overview: "Genius billionaire playboy philanthropist",
                                                                                      thumbnail: "iron_man.jpg")]))
        
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
        let comicResponse = ComicResponse(data: ComicData(results: [Comic(id: 1,
                                                                          name: "Iron Man",
                                                                          overview: "Genius billionaire playboy philanthropist",
                                                                          thumbnail: "iron_man.jpg")]))
        
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
    
    func testFilteredMarvelDataCount() {
        viewModel.filteredMarvelData = [
            Character(id: 1, name: "Iron Man", overview: "", thumbnail: ""),
            Comic(id: 2, name: "Spider-Man", overview: "", thumbnail: ""),
            Comic(id: 3, name: "Batman", overview: "", thumbnail: "")
        ]
        XCTAssertEqual(viewModel.filteredMarvelDataCount, 3)
        viewModel.filteredMarvelData.removeLast()
        XCTAssertEqual(viewModel.filteredMarvelDataCount, 2)
        viewModel.filteredMarvelData.removeAll()
        XCTAssertEqual(viewModel.filteredMarvelDataCount, 0)
    }
    
    func testFetchMarvelNameAndImage() {
        let marvelData1 = Character(id: 1,
                                    name: "Iron Man",
                                    overview: "Genius, billionaire, playboy, philanthropist",
                                    thumbnail: "http://example.com/ironman")
        let marvelData2 = Comic(id: 2,
                                name: "Spider-Man",
                                overview: "Friendly neighborhood superhero",
                                thumbnail: "http://example.com/spiderman")
        
        viewModel.marvelData = [marvelData1, marvelData2]
        
        viewModel.isSearching = false
        let (name1, image1) = viewModel.fetchMarvelNameAndImage(for: 0)
        XCTAssertEqual(name1, "Iron Man")
        XCTAssertEqual(image1, "https://example.com/ironman/portrait_incredible.jpg")
        
        viewModel.isSearching = true
        viewModel.filteredMarvelData = [marvelData1, marvelData2]
        let (name2, image2) = viewModel.fetchMarvelNameAndImage(for: 1)
        XCTAssertEqual(name2, "Spider-Man")
        XCTAssertEqual(image2, "https://example.com/spiderman/portrait_incredible.jpg")
    }
    
    func testNumberOfSectionsForNotFiltering() {
        let marvelData = Character(id: 1,
                                   name: "Iron Man",
                                   overview: "Genius, billionaire, playboy, philanthropist",
                                   thumbnail: "http://example.com/ironman")
        viewModel.isSearching = false
        viewModel.marvelData = [marvelData]
        XCTAssertEqual(viewModel.numberOfSections, 1)
    }
    
    func testNumberOfSectionsForFiltering() {
        let marvelData = Character(id: 1,
                                   name: "Iron Man",
                                   overview: "Genius, billionaire, playboy, philanthropist",
                                   thumbnail: "http://example.com/ironman")
        let marvelData2 = Comic(id: 2,
                                name: "Spider-Man",
                                overview: "Friendly neighborhood superhero",
                                thumbnail: "http://example.com/spiderman")
        viewModel.isSearching = true
        viewModel.filteredMarvelData = [marvelData, marvelData2]
        XCTAssertEqual(viewModel.numberOfSections, 2)
    }
    
    func testHandleSegmentedControlForCharactersSelected() {
        viewModel.handleSegmentedControl(segmentedControlTitle: "Characters")
        XCTAssertEqual(viewModel.marvelDataType, EntityType.character)
        viewModel.handleSegmentedControl(segmentedControlTitle: "Comics")
        XCTAssertEqual(viewModel.marvelDataType, EntityType.comic)
    }
    
    func testFilteredMarvelDataWithSearchText() {
        viewModel.marvelData = [
            Character(id: 1,
                      name: "Spider-Man",
                      overview: "A superhero",
                      thumbnail: "spiderman.jpg"),
            Character(id: 2,
                      name: "Iron Man",
                      overview: "A billionaire playboy philanthropist",
                      thumbnail: "ironman.jpg"),
            Comic(id: 1,
                  name: "Avengers",
                  overview: "A team of superheroes",
                  thumbnail: "avengers.jpg")
        ]
        
        viewModel.filterMarvelData(filteredText: "spider")
        
        XCTAssertTrue(viewModel.isSearching)
        XCTAssertEqual(viewModel.filteredMarvelData.count, 1)
        XCTAssertEqual(viewModel.filteredMarvelData[0].name, "Spider-Man")
        XCTAssertTrue(mockDelegate.reloadViewCalled)
    }
    
    func testFilteredMarvelDataWithNoSearchText() {
        viewModel.marvelData = [
            Character(id: 1,
                      name: "Spider-Man",
                      overview: "A superhero",
                      thumbnail: "spiderman.jpg"),
            Character(id: 2,
                      name: "Iron Man",
                      overview: "A billionaire playboy philanthropist",
                      thumbnail: "ironman.jpg"),
            Comic(id: 1,
                  name: "Avengers",
                  overview: "A team of superheroes",
                  thumbnail: "avengers.jpg")
        ]
        viewModel.filterMarvelData(filteredText: "")
        
        XCTAssertFalse(viewModel.isSearching)
        XCTAssertEqual(viewModel.filteredMarvelData.count, 0)
    }
    
    func testFetchMarvelDataAtIndexWhenNotFiltering() {
        viewModel.marvelData = [
            Character(id: 1,
                      name: "Spider-Man",
                      overview: "A superhero",
                      thumbnail: "spiderman.jpg"),
            Character(id: 2,
                      name: "Iron Man",
                      overview: "A billionaire playboy philanthropist",
                      thumbnail: "ironman.jpg"),
            Comic(id: 1,
                  name: "Avengers",
                  overview: "A team of superheroes",
                  thumbnail: "avengers.jpg")
        ]
        
        viewModel.isSearching = false
        XCTAssertEqual(viewModel.marvelData.count, 3)
        XCTAssertEqual(viewModel.fetchMarvelData(atIndex: 0)?.name, "Spider-Man")
    }
    
    func testFetchMarvelDataAtIndexWhenFiltering() {
        viewModel.filteredMarvelData = [
            Character(id: 1,
                      name: "Spider-Man",
                      overview: "A superhero",
                      thumbnail: "spiderman.jpg"),
            Character(id: 2,
                      name: "Iron Man",
                      overview: "A billionaire playboy philanthropist",
                      thumbnail: "ironman.jpg"),
            Comic(id: 1,
                  name: "Avengers",
                  overview: "A team of superheroes",
                  thumbnail: "avengers.jpg")
        ]
        
        viewModel.isSearching = true
        XCTAssertEqual(viewModel.filteredMarvelData.count, 3)
        XCTAssertEqual(viewModel.fetchMarvelData(atIndex: 1)?.name, "Iron Man")
    }
    
    func testFilterMarvelData_EmptyFilteredMarvelData() {
        viewModel.filteredMarvelData = []
        viewModel.filterMarvelData(filteredText: "")
        XCTAssertTrue(viewModel.hideNoResultsText)
    }
    
    func testFilterMarvelData_NonEmptyFilteredMarvelData() {
        viewModel.filteredMarvelData = [
            Character(id: 1, name: "Spider-Man", overview: "A superhero", thumbnail: "spiderman.jpg")
        ]
        viewModel.filterMarvelData(filteredText: "Spider")
        XCTAssertFalse(viewModel.hideNoResultsText)
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
    func startLoadingIndicator() {
    }
    
    func stopLoadingIndicator() {
    }
    
    var reloadViewCalled = false
    
    func reloadView() {
        reloadViewCalled = true
    }
}
