//
//  HomeScreenDetailsViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/20.
//

import Foundation

class HomeScreenDetailsViewModel {
    
    var character: Character?
    
    func set(character: Character) {
        self.character = character
    }
    
    var characterName: String {
        character?.name ?? ""
    }
    
    var characterDescription: String {
        character?.description ?? ""
    }
}
