//
//  HomeScreenDetailsViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/20.
//

import Foundation

class HomeScreenDetailsViewModel {
    
    var character: MarvelData?
    
    private var homeScreenDetailsRepository: HomeScreenDetailsRepositoryType?
    
    init(homeScreenDetailsRepository: HomeScreenDetailsRepositoryType) {
        self.homeScreenDetailsRepository = homeScreenDetailsRepository
    }
    
    var characterName: String {
        character?.name ?? ""
    }
    
    var characterDescription: String {
        character?.overview ?? ""
    }
    
    func set(character: MarvelData) {
        self.character = character
    }
    
    func saveObjectIntoCoreData() {
        if let character {
            homeScreenDetailsRepository?.saveIntoCoreData(object: character)
        }
    }
}
