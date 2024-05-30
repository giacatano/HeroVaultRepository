//
// GameScreenRepository.swift
// HeroVault
//
// Created by Gia Catano on 2024/04/03.
//

import Foundation

typealias GameResult = Result<GameResponse, NetworkingError>

protocol GameScreenRepositoryType {
    func fetchGames(completion: @escaping (GameResult) -> Void)
    func fetchHighScore() -> String
    func saveHighScore(score: Int)
}

class GameScreenRepository: GameScreenRepositoryType {
    private let apiHandler: APIHandlerType
    private let coreDataHandler: CoreDataHandlerType
    
    init(apiHandler: APIHandlerType, coreDataHandler: CoreDataHandlerType) {
        self.apiHandler = apiHandler
        self.coreDataHandler = coreDataHandler
    }
    
    func fetchGames(completion: @escaping (GameResult) -> Void) {
        apiHandler.request(path: Constants.EndPoints.marvelEvents,
                           networkType: NetworkingRequestType.GET,
                           model: GameResponse.self) { result in
            completion(result)
        }
    }
    
    func fetchHighScore() -> String {
        coreDataHandler.fetchHighScore()
    }
    
    func saveHighScore(score: Int) {
        coreDataHandler.saveHighScore(score: score)
    }
}
