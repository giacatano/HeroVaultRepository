//
//  HomeScreenViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/03/30.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadView()
}

class HomeScreenViewModel {
    
    // MARK: Variables
    
    var characters = [Character]()
    var comics = [Comic]()
    var error: Error?
    
    private let homeScreenRepository: HomeScreenRepositoryType?
    private weak var delegate: ViewModelDelegate?
    
    init(homeScreenRepository: HomeScreenRepositoryType, delegate: ViewModelDelegate) {
        self.homeScreenRepository = homeScreenRepository
        self.delegate = delegate
    }
    
    // MARK: Computes properties
    
    var characterCount: Int {
        characters.count
    }
    
    // MARK: Functions
    
    func fetchCharacters() {
        homeScreenRepository?.fetchCharacters { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let characters):
                for character in characters.data.results {
                    if !character.name.isEmpty && !character.description.isEmpty {
                        self.characters.append(character)
                    }
                }
                delegate?.reloadView()
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func fetchComics() {
        homeScreenRepository?.fetchComics { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let comics):
                self.comics = comics.data.results
                for comic in self.comics {
                    print(comic.title)
                }
            case .failure(let error):
                print(self.error = error)
            }
        }
    }
    
    func createImage(characterIndex: Int) -> String {
        "\(characters[characterIndex].thumbnail.path)/standard_fantastic.jpg".convertToHttps()
    }
    
    func fetchCharacters(atIndex: Int) -> Character? {
        characters[atIndex]
    }
}
