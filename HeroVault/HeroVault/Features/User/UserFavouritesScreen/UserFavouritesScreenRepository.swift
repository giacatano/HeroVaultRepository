//
//  UserFavouritesScreenRepository.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation

    //MARK: Protocol

protocol UserFavouritesScreenRepositoryType {
    func fetchCharactersFromCoreData() -> [MarvelData]?
    func fetchNames() -> [String]?
}

    //MARK: Repository

class UserFavouritesScreenRepository: UserFavouritesScreenRepositoryType {

    private let coreDataHandler = CoreDataHandler()
    
    func fetchCharactersFromCoreData() -> [MarvelData]? {
        return coreDataHandler.fetchAllObjectsFromCoreData(entityType: .character)
    }
    
    func fetchNames() -> [String]? {
        return coreDataHandler.showAllNames()
    }
}
