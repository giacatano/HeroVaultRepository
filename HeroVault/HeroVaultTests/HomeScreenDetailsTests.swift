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
                                        thumbnail: "iron_man.jpg", id: 8, hasBeenfavourited: true)
        
        viewModel.set(marvelData: marvelData)
        let name = viewModel.marvelDataName
        
        XCTAssertEqual(name, "Iron Man")
    }
    
    func testMarvelDataEmptyName() {
        
        var name = viewModel.marvelDataName
        XCTAssertEqual(name, "")
    }
    
    func testMarvelDataDescription() {
        let marvelData = MockMarvelData(name: "Iron Man",
                                        overview: "Genius billionaire playboy philanthropist",
                                        thumbnail: "iron_man.jpg", id: 8, hasBeenfavourited: true)
        
        viewModel.set(marvelData: marvelData)
        let description = viewModel.marvelDataDescription
        
        XCTAssertEqual(description, "Genius billionaire playboy philanthropist")
    }
    
    func testMarvelDataEmptyDescription() {
        
        var description = viewModel.marvelDataDescription
        XCTAssertEqual(description, "")
    }
    
    func testCreateImage() {
        let marvelData = MockMarvelData(name: "Iron Man",
                                        overview: "Genius billionaire playboy philanthropist",
                                        thumbnail: "iron_man.jpg", id: 8, hasBeenfavourited: true)
        
        viewModel.set(marvelData: marvelData)
        let imageUrl = viewModel.createImage()
        
        XCTAssertEqual(imageUrl, "iron_man.jpg/portrait_incredible.jpg".convertToHttps())
    }
    
    func testSaveObjectIntoCoreData() {
        let marvelData = MockMarvelData(name: "Iron Man",
                                        overview: "Genius billionaire playboy philanthropist",
                                        thumbnail: "iron_man.jpg", id: 8, hasBeenfavourited: true)
        
        viewModel.set(marvelData: marvelData)
        viewModel.saveObjectIntoCoreData()
        
        XCTAssertTrue(mockRepository.saveIntoCoreDataCalled)
    }
}

// MARK: Mock Classes

class MockHomeScreenDetailsRepository: HomeScreenDetailsRepositoryType {
    var saveIntoCoreDataCalled = false
    var savedObject: MarvelData?
    
    func saveIntoCoreData(object: MarvelData) {
        saveIntoCoreDataCalled = true
        savedObject = object
    }
}

class MockMarvelData: MarvelData {
    var id: Int
    var hasBeenfavourited: Bool
    var name: String
    var overview: String
    var thumbnail: String
    
    init(name: String, overview: String, thumbnail: String, id: Int, hasBeenfavourited: Bool) {
        self.name = name
        self.overview = overview
        self.thumbnail = thumbnail
        self.id = id
        self.hasBeenfavourited = hasBeenfavourited
    }
}
