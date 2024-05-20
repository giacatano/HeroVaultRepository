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
    
    init(homeScreenDetailsRepository: HomeScreenDetailsRepositoryType) {
        self.homeScreenDetailsRepository = homeScreenDetailsRepository
    }
    
    // MARK: Computed Properties
    
    var marvelDataName: String {
        marvelData?.name ?? ""
    }
    
    var marvelDataDescription: String {
        guard let description = marvelData?.overview else { return "" }
        return description.isEmpty ? Constants.ErrorManagement.descriptionError : marvelData?.overview ?? ""
    }
    
    // MARK: Functions
    
    func createImage() -> String {
        guard var imageName = (marvelData?.thumbnail) else { return "" }
        imageName.append("/portrait_incredible.jpg")
        return imageName.convertToHttps()
    }
    
    func set(marvelData: MarvelData) {
        self.marvelData = marvelData
    }
    
    func saveObjectIntoCoreData() {
        if let marvelData {
            homeScreenDetailsRepository?.saveIntoCoreData(object: marvelData)
        }
    }
    
    func hasObjectBeenFavourited() -> Bool {
        if let marvelData {
            return homeScreenDetailsRepository?.hasObjectBeenFavourited(object: marvelData) ?? false
        }
        return false
    }
    
    func removeFromFavourites() {
        if let marvelData {
            homeScreenDetailsRepository?.removeFavouritedFromCoreData(object: marvelData)
        }
    }
}
