//
//  UserFavouritesScreenRepository.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation

// MARK: Protocol

protocol UserFavouritesScreenRepositoryType {
    func fetchMarvelDataFromCoreData(marvelDataType: EntityType) -> [MarvelData]?
}

// MARK: Repository

class UserFavouritesScreenRepository: UserFavouritesScreenRepositoryType {
    
    private let coreDataHandler = CoreDataHandler()
    
    func fetchMarvelDataFromCoreData(marvelDataType: EntityType) -> [MarvelData]? {
        coreDataHandler.fetchAllObjectsFromCoreData(entityType: marvelDataType)
    }
}
