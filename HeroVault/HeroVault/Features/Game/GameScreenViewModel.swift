//
// GameScreenViewModel.swift
// HeroVault
//
// Created by Gia Catano on 2024/04/03.
//

import Foundation

class GameScreenViewModel {
    
    // MARK: Variables
    
    var error: Error?
    var indexOfCurrentGameThumbnails = 0
    var cellsClickable = true
    private var currentScore = 0
    private var games = [Game]()
    private var currentGameThumbnails = [String]()
    private var currentGameDescription = ""
    private var correctThumbnail = ""
    private let gameScreenRepository: GameScreenRepositoryType
    private weak var delegate: ViewModelProtocol?
    
    init(gameScreenRepository: GameScreenRepositoryType, delegate: ViewModelProtocol) {
        self.gameScreenRepository = gameScreenRepository
        self.delegate = delegate
    }
    
    // MARK: Computed Properties
    
    var generateDescription: String {
        currentGameDescription = games.randomElement()?.overview ?? ""
        return currentGameDescription
    }
    
    var score: String {
        String(currentScore)
    }
    
    var highScore: String {
        gameScreenRepository.fetchHighScore()
    }
    
    var populateCellImage: String {
        guard !currentGameThumbnails.isEmpty else { return "" }
        let thumbnail = currentGameThumbnails[indexOfCurrentGameThumbnails]
        indexOfCurrentGameThumbnails += 1
        return thumbnail
    }
    
    var correctIndex: Int? {
        currentGameThumbnails.firstIndex(of: correctThumbnail)
    }
    
    // MARK: Functions
    
    func fetchEvents() {
        delegate?.startLoadingIndicator()
        gameScreenRepository.fetchGames { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let events):
                games = events.data.results
                delegate?.reloadView()
            case .failure(let error):
                print("error: \(error)")
            }
            delegate?.stopLoadingIndicator()
        }
    }
    
    func newHighScore() -> Bool {
        var newScore = false
        if Int(score) ?? 0 > Int(highScore) ?? 0 {
            gameScreenRepository.saveHighScore(score: currentScore)
            newScore = true
        }
        return newScore
    }
    
    func playAgain() {
        delegate?.reloadView()
    }
    
    func generateImage() {
        let result = generateRandomImages()
        if !result.isEmpty {
            currentGameThumbnails = result.shuffled()
        }
    }
    
    func checkAnswer(atIndex: Int) -> Bool {
        var answer = false
        if correctThumbnail == currentGameThumbnails[atIndex] {
            currentScore += 1
            answer = true
        }
        return answer
    }
    
    func resetScore() {
        currentScore = 0
    }
    
    private func generateRandomImages() -> [String] {
        var images = [String]()
        guard let correctGameThumbnail = games.first(where: { $0.overview == currentGameDescription })?.thumbnail else { return [] }
        correctThumbnail = "\(correctGameThumbnail)/portrait_incredible.jpg".convertToHttps()
        let incorrectThumbnails = Set(games.filter { $0.overview != currentGameDescription }
            .map { "\($0.thumbnail)/portrait_incredible.jpg".convertToHttps() })
        let randomIncorrectThumbnails = Array(incorrectThumbnails.shuffled().prefix(3))
        if images.count > 4 {
            images = []
        } else {
            images.append(correctThumbnail)
            images.append(contentsOf: randomIncorrectThumbnails)
        }
        return images
    }
}
