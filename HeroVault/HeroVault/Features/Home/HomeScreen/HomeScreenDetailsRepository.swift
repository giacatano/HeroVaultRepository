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
}

    // MARK: Repository 

class HomeScreenDetailsRepository: HomeScreenDetailsRepositoryType {
    
    private let coreDataHandler = CoreDataHandler()
    
    func saveIntoCoreData(object: MarvelData) {
        coreDataHandler.saveObjectIntoCoreData(object)
    }
}
