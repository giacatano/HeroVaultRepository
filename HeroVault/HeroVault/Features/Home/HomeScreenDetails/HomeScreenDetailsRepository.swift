//
//  HomeScreenDetailsRepository.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/01.
//

import Foundation

// MARK: Protocol

protocol HomeScreenDetailsRepositoryType {
    func saveIntoCoreData(object: MarvelData)
    func hasObjectBeenFavourited(object: MarvelData) -> Bool
    func removeFavouritedFromCoreData(object: MarvelData)
}

// MARK: Repository 

class HomeScreenDetailsRepository: HomeScreenDetailsRepositoryType {
    
    private let coreDataHandler = CoreDataHandler()
    
    func saveIntoCoreData(object: MarvelData) {
        coreDataHandler.saveObjectIntoCoreData(object)
    }
    
    func hasObjectBeenFavourited(object: MarvelData) -> Bool {
        let entityType = (object is Character) ? EntityType.character : EntityType.comic
        return coreDataHandler.doesObjectExistInCoreData(object, entityType: entityType)
    }
    
    func removeFavouritedFromCoreData(object: MarvelData) {
        coreDataHandler.deleteObjectFromCoreData(object)
    }
}
