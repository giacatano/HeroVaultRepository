//
//  GameScreenTests.swift
//  HeroVaultTests
//
//  Created by Gia Catano on 2024/06/26.
//

import XCTest
@testable import HeroVault

class GameScreenViewModelTests: XCTestCase {
    var viewModel: GameScreenViewModel!
    var mockRepository: MockGameScreenRepository!
    var mockDelegate: MockGameScreenViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockGameScreenRepository()
        mockDelegate = MockGameScreenViewModelProtocol()
        viewModel = GameScreenViewModel(gameScreenRepository: mockRepository, delegate: mockDelegate)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testFetchEventsSuccess() {
        let mockGameResponse = GameResponse(data: GameData(results: [Game(overview: "Game 1", thumbnail: "thumbnail1"), Game(overview: "Game 2", thumbnail: "thumbnail2")]))
        
        mockRepository.gameResponse = .success(mockGameResponse)
        viewModel.fetchEvents()
        XCTAssertTrue(mockDelegate.didCallReloadView)
        XCTAssertTrue(mockDelegate.didCallStartLoadingIndicator)
    }
    
    func testFetchEventsFailure() {
        mockRepository.gameResponse = .failure(NetworkingError.internalError)
        viewModel.fetchEvents()
    }
    
    func testGenerateDescription() {
        _ = GameResponse(data: GameData(results: [Game(overview: "Game 1", thumbnail: "thumbnail1"), Game(overview: "Game 2", thumbnail: "thumbnail2")]))
        _ = viewModel.generateDescription
    }
    
    func testScore() {
        viewModel.resetScore()
        XCTAssertEqual(viewModel.score, "0")
        let correct = viewModel.checkAnswer(atIndex: 0)
        if correct {
            XCTAssertEqual(viewModel.score, "1")
        } else {
            XCTAssertEqual(viewModel.score, "0")
        }
    }
    
    func testHighScore() {
        mockRepository.highScore = "5"
        let highScore = viewModel.highScore
        XCTAssertEqual(highScore, "5")
    }
    
    func testNewHighScore() {
        mockRepository.highScore = "5"
        _ = viewModel.newHighScore()
    }
    
    func testPlayAgain() {
        viewModel.playAgain()
    }
    
    func testGenerateImage() {
        _ = GameResponse(data: GameData(results: [Game(overview: "Game 1", thumbnail: "thumbnail1"), Game(overview: "Game 2", thumbnail: "thumbnail2")]))
        viewModel.generateDescription
        
        viewModel.generateImage()
    }
    
    func testCheckAnswer() {
        let mockGameResponse = GameResponse(data: GameData(results: [Game(overview: "Game 1", thumbnail: "thumbnail1"), Game(overview: "Game 2", thumbnail: "thumbnail2")]))
        
        viewModel.generateDescription
        viewModel.generateImage()
        let correctIndex = viewModel.correctIndex
        _ = viewModel.checkAnswer(atIndex: correctIndex ?? 0)
    }
    
    func testResetScore() {
        viewModel.resetScore()
    }
}

//MARK: Mock CLasses

class MockGameScreenRepository: GameScreenRepositoryType {
    var gameResponse: GameResult?
    var highScore: String = "0"
    var savedHighScore: Int?
    
    func fetchGames(completion: @escaping (GameResult) -> Void) {
        if let response = gameResponse {
            completion(response)
        }
    }
    
    func fetchHighScore() -> String {
        return highScore
    }
    
    func saveHighScore(score: Int) {
        savedHighScore = score
    }
}

class MockGameScreenViewModelProtocol: ViewModelProtocol {
    var didCallReloadView = false
    var didCallStartLoadingIndicator = false
    var didCallStopLoadingIndicator = false
    var didCallShowSuccess = false
    var didCallShowError = false
    
    func reloadView() {
        didCallReloadView = true
    }
    
    func startLoadingIndicator() {
        didCallStartLoadingIndicator = true
    }
    
    func stopLoadingIndicator() {
        didCallStopLoadingIndicator = true
    }
    
    func showSuccess(title: String, message: String) {
        didCallShowSuccess = true
    }
    
    func showError(title: String, message: String) {
        didCallShowError = true
    }
}
