//
//  UserFavouritesViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation

class UserFavouritesScreenViewModel: ViewModelDelegate {
    func reloadView() {
    }
    
    func createImage(characterIndex: Int) -> String {
        "Burger"
    }
    
    var charcter = [Character(id: 1009146, name: "Abomination (Emil Blonsky)", overview: "Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.", thumbnail: HeroVault.CharacterPictures(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04", jpg: "jpg"))]
    
    private var userFavouritesScreenRepository: UserFavouritesScreenRepositoryType?
    private weak var delegate: ViewModelDelegate?
    
    init(userFavouritesScreenRepository: UserFavouritesScreenRepositoryType, delegate: ViewModelDelegate) {
        self.userFavouritesScreenRepository = userFavouritesScreenRepository
        self.delegate = delegate
    }
    
    func fetchAllCharactersFromCoreData() -> [MarvelData] {
        guard let characters = userFavouritesScreenRepository?.fetchCharactersFromCoreData() else { return [] }
        return characters
    }
    
    func fetchAllNamesOfCharactersInCoreData() -> [String] {
        guard let names = userFavouritesScreenRepository?.fetchNames() else { return [] }
        return names
    }
}

// TODO: Do all table view stuff with delegates
