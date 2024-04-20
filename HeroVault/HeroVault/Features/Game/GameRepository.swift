//
//  GameRepository.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/03.
//

import Foundation

typealias GameResult = Result<GameResponse, NetworkingError>

protocol GameRepositoryType {
    func fetchGames(completion: @escaping (GameResult) -> Void)
}

class GameRepository: GameRepositoryType {
    
    private let apiHandler = APIHandler()
    
    func fetchGames(completion: @escaping (GameResult) -> Void) {
        apiHandler.request(path: Constants.EndPoints.marvelStoryDescriptions,
                           networkType: NetworkingRequestType.GET,
                           model: GameResponse.self) { result in
            completion(result)
        }
    }
}
