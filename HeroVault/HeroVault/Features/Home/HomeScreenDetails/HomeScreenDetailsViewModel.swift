//
//  HomeScreenDetailsViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/20.
//

import Foundation

class HomeScreenDetailsViewModel {
    
    // MARK: Variables
    
    var marvelData: MarvelData?
    private var homeScreenDetailsRepository: HomeScreenDetailsRepositoryType?
    
    var marvelDataName: String {
        marvelData?.name ?? ""
    }
    
    var marvelDataDescription: String {
        marvelData?.overview ?? ""
    }
    
    // MARK: Functions
    
    init(homeScreenDetailsRepository: HomeScreenDetailsRepositoryType) {
        self.homeScreenDetailsRepository = homeScreenDetailsRepository
    }
    
    func set(marvelData: MarvelData) {
        self.marvelData = marvelData
    }
    
    func saveObjectIntoCoreData() {
        if let marvelData {
            homeScreenDetailsRepository?.saveIntoCoreData(object: marvelData)
        }
    }
}
