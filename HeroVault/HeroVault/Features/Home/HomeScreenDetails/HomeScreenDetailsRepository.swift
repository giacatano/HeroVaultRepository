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
    
    // MARK: Variables
    
    private let coreDataHandler: CoreDataHandlerType
    
    init(coreDataHandler: CoreDataHandlerType) {
        self.coreDataHandler = coreDataHandler
    }
    
    // MARK: Functions
    
    func saveIntoCoreData(object: MarvelData) {
        coreDataHandler.saveObjectIntoCoreData(object)
    }
    
    func hasObjectBeenFavourited(object: MarvelData) -> Bool {
        let entityType = (object is Character || object is CoreDataCharacter) ? EntityType.character : EntityType.comic
        return coreDataHandler.checkObjectExistInCoreData(object, entityType: entityType)
    }
    
    func removeFavouritedFromCoreData(object: MarvelData) {
        coreDataHandler.deleteObjectFromCoreData(object)
    }
}
