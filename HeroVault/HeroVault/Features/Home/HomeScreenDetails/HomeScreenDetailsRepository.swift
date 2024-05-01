//
//  HomeScreenDetailsRepository.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/01.
//

import Foundation

protocol HomeScreenDetailsRepositoryType {
    func saveIntoCoreData(object: MarvelData)
}

class HomeScreenDetailsRepository: HomeScreenDetailsRepositoryType {
    
    private let coreDataHandler = CoreDataHandler()
    
    func saveIntoCoreData(object: MarvelData) {
        coreDataHandler.saveObjectIntoCoreData(object)
    }
}
