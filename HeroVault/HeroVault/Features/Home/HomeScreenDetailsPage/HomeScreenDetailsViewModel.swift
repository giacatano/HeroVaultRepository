//
//  HomeScreenDetailsViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/20.
//

import Foundation

class HomeScreenDetailsViewModel {
    

    
    var character: Test?
    
    func set(character: Test) {
        self.character = character
    }
    
    var characterName: String {
        character?.name ?? ""
    }
    
    var characterDescription: String {
        character?.description ?? ""
    }
    
    var characterID: Int {
        character?.id ?? -1
    }
}
