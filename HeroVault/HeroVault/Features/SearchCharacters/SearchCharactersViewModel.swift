//
//  SearchCharactersViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/03/30.
//

import Foundation

class CharacterNamesViewModel {
    
    var characters = [Characters]()
    var error: Error?
    
    private let characterRepository: CharacterRepositoryType
    
    init(characterRepository: CharacterRepositoryType) {
        self.characterRepository = characterRepository
    }
    
    func fetchCharacters() {
        characterRepository.fetchCharacters { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characters):
                self.characters = characters.data.results
                for character in self.characters {
                    print(character.name)
                }
            case .failure(let error):
                self.error = error
            }
        }
    }
}
