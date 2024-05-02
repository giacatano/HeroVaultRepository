//
//  UserFavouritesViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation

class UserFavouritesScreenViewModel: ViewModelDelegate {
    
    // MARK: Variables
    
    private var userFavouritesScreenRepository: UserFavouritesScreenRepositoryType?
    private weak var delegate: ViewModelDelegate?
    
    // MARK: Functions
    
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
    
    func reloadView() {
    }
    
    func createImage(characterIndex: Int) -> String {
        "Spiderman"
    }
}
