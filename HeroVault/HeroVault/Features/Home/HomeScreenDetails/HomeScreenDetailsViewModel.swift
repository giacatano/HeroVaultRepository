//
//  HomeScreenDetailsViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/20.
//

import Foundation

class HomeScreenDetailsViewModel {
    
    //MARK: Variables
    
    var character: MarvelData?
    private var homeScreenDetailsRepository: HomeScreenDetailsRepositoryType?
    
    var characterName: String {
        character?.name ?? ""
    }
    
    var characterDescription: String {
        character?.overview ?? ""
    }
    
    //MARK: Functions
    
    init(homeScreenDetailsRepository: HomeScreenDetailsRepositoryType) {
        self.homeScreenDetailsRepository = homeScreenDetailsRepository
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
