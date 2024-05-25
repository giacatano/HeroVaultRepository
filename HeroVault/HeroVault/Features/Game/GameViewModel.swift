//
//  GameViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/03.
//

import Foundation

class GameViewModel {
    
    var events = [Game]()
    var error: Error?
    
    private let gameRepository: GameRepositoryType
    
    init(gameRepository: GameRepositoryType) {
        self.gameRepository = gameRepository
    }
    
    func fetchEvents() {
        gameRepository.fetchGames { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let events):
                self.events = events.data.results
            case .failure(let error):
                #warning("WIP-Error handling")
            }
        }
    }
}
