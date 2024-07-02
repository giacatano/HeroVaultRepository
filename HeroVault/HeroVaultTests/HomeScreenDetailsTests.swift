//
//  HomeScreenDetailsTests.swift
//  HeroVaultTests
//
//  Created by Gia Catano on 2024/05/08.
//

import XCTest
@testable import HeroVault

class HomeScreenDetailsViewModelTests: XCTestCase {
    var viewModel: HomeScreenDetailsViewModel!
    var mockRepository: MockHomeScreenDetailsRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockHomeScreenDetailsRepository()
        viewModel = HomeScreenDetailsViewModel(homeScreenDetailsRepository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testMarvelDataName() {
        let marvelData = MockMarvelData(name: "Iron Man",
                                        overview: "Genius billionaire playboy philanthropist",
                                        thumbnail: "iron_man.jpg",
                                        id: 8)
        
        viewModel.set(marvelData: marvelData)
        let name = viewModel.marvelDataName
        XCTAssertEqual(name, "Iron Man")
    }
    
    func testMarvelDataEmptyName() {
        let name = viewModel.marvelDataName
        XCTAssertEqual(name, "")
    }
    
    func testMarvelDataDescription() {
        let marvelData = MockMarvelData(name: "Iron Man",
                                        overview: "Genius billionaire playboy philanthropist",
                                        thumbnail: "iron_man.jpg",
                                        id: 8)
        
        viewModel.set(marvelData: marvelData)
        let description = viewModel.marvelDataDescription
        XCTAssertEqual(description, "Genius billionaire playboy philanthropist")
    }
    
    func testMarvelDataEmptyDescription() {
        let description = viewModel.marvelDataDescription
        XCTAssertEqual(description, "")
    }
    
    func testCreateImage() {
        let marvelData = MockMarvelData(name: "Iron Man",
                                        overview: "Genius billionaire playboy philanthropist",
                                        thumbnail: "iron_man.jpg",
                                        id: 8)
        
        viewModel.set(marvelData: marvelData)
        let imageUrl = viewModel.createImage()
        XCTAssertEqual(imageUrl, "iron_man.jpg/portrait_incredible.jpg".convertToHttps())
    }
    
    func testSaveObjectIntoCoreData() {
        let marvelData = MockMarvelData(name: "Iron Man",
                                        overview: "Genius billionaire playboy philanthropist",
                                        thumbnail: "iron_man.jpg",
                                        id: 8)
        
        viewModel.set(marvelData: marvelData)
        viewModel.saveObjectIntoCoreData()
        XCTAssertTrue(mockRepository.saveIntoCoreDataCalled)
    }
    
    func testHasObjectBeenFavourited() {
        let mockRepository = MockHomeScreenDetailsRepository()
        let viewModel = HomeScreenDetailsViewModel(homeScreenDetailsRepository: mockRepository)
        let mockMarvelData = MockMarvelData(name: "", overview: "", thumbnail: "String", id: 0)
        
        mockRepository.saveIntoCoreDataCalled = true
        viewModel.set(marvelData: mockMarvelData)
        let isFavourited = viewModel.hasObjectBeenFavourited()
        XCTAssertTrue(isFavourited)
        XCTAssertTrue(mockRepository.hasObjectBeenFavourited(object: mockMarvelData))
    }
}

// MARK: Mock Classes

class MockHomeScreenDetailsRepository: HomeScreenDetailsRepositoryType {
    func hasObjectBeenFavourited(object: HeroVault.MarvelData) -> Bool {
        return true
    }
    
    func removeFavouritedFromCoreData(object: HeroVault.MarvelData) {
    }
    
    var saveIntoCoreDataCalled = false
    var savedObject: MarvelData?
    
    func saveIntoCoreData(object: MarvelData) {
        saveIntoCoreDataCalled = true
        savedObject = object
    }
}

class MockMarvelData: MarvelData {
    var id: Int
    var name: String
    var overview: String
    var thumbnail: String
    
    init(name: String, overview: String, thumbnail: String, id: Int) {
        self.name = name
        self.overview = overview
        self.thumbnail = thumbnail
        self.id = id
    }
}
