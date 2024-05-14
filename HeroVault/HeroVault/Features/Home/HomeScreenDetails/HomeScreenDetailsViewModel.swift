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
        guard let description = marvelData?.overview else { return "" }
        return description.isEmpty ? Constants.ErrorManagement.descriptionError : marvelData?.overview ?? ""
    }
    
    func createImage() -> String {
        guard var imageName = (marvelData?.thumbnail) else { return "" }
        imageName.append("/portrait_incredible.jpg")
        return imageName.convertToHttps()
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
