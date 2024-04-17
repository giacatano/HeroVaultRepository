//
//  SearchCharactersViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/03/30.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadView()
}

class CharacterNamesViewModel {
    
    var characters = [Characters]()
    var error: Error?
    
    private let characterRepository: CharacterRepositoryType?
    private weak var delegate: ViewModelDelegate?
    
    init(characterRepository: CharacterRepositoryType, delegate: ViewModelDelegate) {
        self.characterRepository = characterRepository
        self.delegate = delegate
    }
    
    var characterCount: Int {
        characters.count
    }
    
    func fetchCharacters() {
        characterRepository?.fetchCharacters { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let characters):
                self.characters = characters.data.results
                for character in self.characters {
                    print(character.name)
                }
                delegate?.reloadView()
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    //change name to fetchImage
    func createImage(characterIndex: Int) -> String {
        "\(characters[characterIndex].thumbnail.path)/standard_fantastic.jpg".convertToHttps()
    }
}

//fetch name function
