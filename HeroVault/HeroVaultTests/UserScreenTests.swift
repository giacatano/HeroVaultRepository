//
//  UserScreenTests.swift
//  HeroVaultTests
//
//  Created by Gia Catano on 2024/06/27.
//

import XCTest
@testable import HeroVault

class UserScreenViewModelTests: XCTestCase {
    var viewModel: UserScreenViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = UserScreenViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testSetMarvelDataTypeCharacter() {
        let marvelDataType: EntityType = .character
        
        viewModel.set(marvelDataType: marvelDataType)
        XCTAssertEqual(viewModel.marvelDataType, .character, "The marvelDataType should be set to .character")
    }
    
    func testSetMarvelDataTypeComic() {
        let marvelDataType: EntityType = .comic
        
        viewModel.set(marvelDataType: marvelDataType)
        XCTAssertEqual(viewModel.marvelDataType, .comic, "The marvelDataType should be set to .comic")
    }
    
    func testMarvelDataTypeInitiallyNil() {
        XCTAssertNil(viewModel.marvelDataType, "The marvelDataType should initially be nil")
    }
}
