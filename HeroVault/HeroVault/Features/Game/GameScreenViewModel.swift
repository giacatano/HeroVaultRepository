//
//  GameScreenViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/03.
//

import Foundation

class GameScreenViewModel {
    
    // MARK: Variables
    
    var error: Error?
    private var games = [Game]()
    private var currentGameDescription = ""
    private var currentGameThumbnails = [String]()
    private let gameScreenRepository: GameScreenRepositoryType
    private weak var delegate: ViewModelProtocol?
    
    init(gameScreenRepository: GameScreenRepositoryType, delegate: ViewModelProtocol) {
        self.gameScreenRepository = gameScreenRepository
        self.delegate = delegate
    }
    
    // MARK: Functions
    
    func fetchEvents() {
        gameScreenRepository.fetchGames { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let events):
                self.games = events.data.results
                print(events)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func generateDescription() -> String {
        currentGameDescription = games.randomElement()?.overview ?? ""
        return currentGameDescription
    }
    
    func generateImage() -> String {
        let currentGameThumbnail = games.randomElement()?.thumbnail ?? ""
        currentGameThumbnails.append(currentGameThumbnail)
        return "\(currentGameThumbnail)/portrait_incredible.jpg".convertToHttps()
    }
    
    func checkAnswer(atIndex: Int) -> Bool {
        let correctGame = games.first { $0.overview == currentGameDescription }
        return correctGame?.thumbnail == currentGameThumbnails[atIndex] ? true : false
    }
    
    func playGameAgain() {
        delegate?.reloadView()
      }
}
