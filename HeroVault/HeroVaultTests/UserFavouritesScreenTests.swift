//
//  UserFavouritesScreenTests.swift
//  HeroVaultTests
//
//  Created by Gia Catano on 2024/06/27.
//

import XCTest
@testable import HeroVault

class UserFavouritesScreenViewModelTests: XCTestCase {
    var viewModel: UserFavouritesScreenViewModel!
    var mockRepository: MockUserFavouritesScreenRepository!
    var mockDelegate: MockUserFavouritesScreenViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockUserFavouritesScreenRepository()
        mockDelegate = MockUserFavouritesScreenViewModelProtocol()
        viewModel = UserFavouritesScreenViewModel(userFavouritesScreenRepository: mockRepository, delegate: mockDelegate)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testFetchAllMarvelDataFromCoreData_withData() {
        let mockMarvelData1 = MockMarvel(id: 1, name: "Spider-Man", overview: "Overview 1", thumbnail: "thumbnail1.jpg")
        let mockMarvelData2 = MockMarvel(id: 2, name: "Iron Man", overview: "Overview 2", thumbnail: "thumbnail2.jpg")
        mockRepository.marvelDataToReturn = [mockMarvelData1, mockMarvelData2]
        
        viewModel.set(marvelDataType: .character)
        viewModel.fetchAllMarvelDataFromCoreData()
        XCTAssertEqual(viewModel.marvelDataListCount, 2)
        XCTAssertFalse(viewModel.showFavouritesText)
    }
    
    func testFetchAllMarvelDataFromCoreData_noData() {
        mockRepository.marvelDataToReturn = []
        
        viewModel.set(marvelDataType: .character)
        viewModel.fetchAllMarvelDataFromCoreData()
        XCTAssertEqual(viewModel.marvelDataListCount, 0)
        XCTAssertTrue(viewModel.showFavouritesText)
    }
    
    func testFetchMarvelNameAndImage() {
        let mockMarvelData1 = MockMarvel(id: 1, name: "Spider-Man", overview: "Overview 1", thumbnail: "thumbnail1.jpg")
        
        viewModel.set(marvelDataType: .character)
        mockRepository.marvelDataToReturn = [mockMarvelData1]
        viewModel.fetchAllMarvelDataFromCoreData()
        let (name, _) = viewModel.fetchMarvelNameAndImage(for: 0)
        XCTAssertEqual(name, "Spider-Man")
    }
    
    func testFetchMarvelData() {
        let mockMarvelData1 = MockMarvel(id: 1, name: "Spider-Man", overview: "Overview 1", thumbnail: "thumbnail1.jpg")
        
        viewModel.set(marvelDataType: .character)
        mockRepository.marvelDataToReturn = [mockMarvelData1]
        viewModel.fetchAllMarvelDataFromCoreData()
        let marvelData = viewModel.fetchMarvelData(atIndex: 0)
        XCTAssertEqual(marvelData?.name, "Spider-Man")
    }
    
    func testFavouritesScreenTitle_forCharacter() {
        viewModel.set(marvelDataType: .character)
        XCTAssertEqual(viewModel.favouritesScreenTitle, "Characters")
    }
    
    func testFavouritesScreenTitle_forComic() {
        viewModel.set(marvelDataType: .comic)
        XCTAssertEqual(viewModel.favouritesScreenTitle, "Comics")
    }
}

// MARK: Mock Classes

class MockUserFavouritesScreenRepository: UserFavouritesScreenRepositoryType {
    var marvelDataToReturn: [MarvelData]?
    
    func fetchMarvelDataFromCoreData(marvelDataType: EntityType) -> [MarvelData]? {
        return marvelDataToReturn
    }
}

class MockUserFavouritesScreenViewModelProtocol: ViewModelProtocol {
    var reloadViewCalled = false
    var startLoadingIndicatorCalled = false
    var stopLoadingIndicatorCalled = false
    var showSuccessCalled = false
    var showErrorCalled = false
    
    func reloadView() {
        reloadViewCalled = true
    }
    
    func startLoadingIndicator() {
        startLoadingIndicatorCalled = true
    }
    
    func stopLoadingIndicator() {
        stopLoadingIndicatorCalled = true
    }
    
    func showSuccess(title: String, message: String) {
        showSuccessCalled = true
    }
    
    func showError(title: String, message: String) {
        showErrorCalled = true
    }
}

struct MockMarvel: MarvelData {
    var id: Int
    var name: String
    var overview: String
    var thumbnail: String
}
