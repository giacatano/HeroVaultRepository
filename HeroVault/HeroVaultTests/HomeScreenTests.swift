//
//  HomeScreenTests.swift
//  HeroVaultTests
//
//  Created by Gia Catano on 2024/05/06.
//

//import XCTest
//@testable import HeroVault
//
//class MockRepository: HomeScreenRepositoryType {
//    
//    let mockComicData = ComicData(results: [Comic(id: 8, name: "String", overview: "", thumbnail: "", hasBeenfavourited: false), Comic(id: 8, name: "jj", overview: "", thumbnail: "", hasBeenfavourited: false)])
//    let mockCharacterData = CharacterData(results: [Character(id: 6, name: "", overview: "", thumbnail: "", hasBeenfavourited: false),Character(id: 6, name: "", overview: "", thumbnail: "", hasBeenfavourited: false)])
//    
//    func fetchComics(completion: @escaping (HeroVault.ComicResult) -> Void) {
//        let result = ComicResponse(data: mockComicData)
//        return completion(Result.success(result))
//    }
//    
//    func fetchCharacters(completion: @escaping (HeroVault.CharacterResult) -> Void) {
//        let result = CharacterResponse(data: mockCharacterData)
//        return completion(Result.success(result))
//    }
//}
//
//class MockDelegate: ViewModelDelegate {
//    
//    func reloadView() {
//        
//    }
//}
//
//final class HomeScreenTests: XCTestCase {
//    
//    var viewModelUnderTests: HomeScreenViewModel!
//    var mockRepository: HomeScreenRepositoryType!
//    var mockDelegate: ViewModelDelegate!
//    
//    override func setUp() {
//        
//        mockRepository = MockRepository()
//        mockDelegate = MockDelegate()
//        viewModelUnderTests = HomeScreenViewModel(homeScreenRepository: mockRepository, delegate: mockDelegate)
//    }
//    
//    func testMarvelDataCount() {
//        viewModelUnderTests.set(marvelDataType: .character)
//        viewModelUnderTests.fetchMarvelData()
////        let expectedResult = Comic(id: 8, name: "String", overview: "", thumbnail: "", hasBeenfavourited: false)
////        let result = try XCTUnwrap(viewModelUnderTest.)
//        let result = viewModelUnderTests.marvelDataCount
//        
//        //  let result = try XCTUnwrap(viewModelUnderTest.track(atIndex: 1)?.artistName)
//        
//        XCTAssertEqual(result, 0)
//        
//        // let result = viewModelUnderTests.marvelDataCount
//        // XCTAssertEqual(result, 0)
//    }
//}



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
