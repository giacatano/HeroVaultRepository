//
//  EventsViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/03.
//

import Foundation

class GameViewModel {
    
    var events = [Game]()
    var error: Error?
    
    private let gameRespository: GameRepositoryType
    
    init(gameRespository: GameRepositoryType) {
        self.gameRespository = gameRespository
    }
    
    func fetchEvents() {
        gameRespository.fetchGames { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let events):
                self.events = events.data.results
                for event in self.events {
//                    print(event)
                }
            case .failure(let error):
                print(self.error = error)
            }
        }
    }
}
