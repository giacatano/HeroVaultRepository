//
//  UserFavouritesViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation

class UserFavouritesScreenViewModel {
    
    // MARK: Variables
    
    private var marvelDataList: [MarvelData]?
    private var userFavouritesScreenRepository: UserFavouritesScreenRepositoryType?
    private var marvelDataType: EntityType?
    var showFavouritesText: Bool
    
    init(userFavouritesScreenRepository: UserFavouritesScreenRepositoryType, delegate: ViewModelProtocol) {
        self.userFavouritesScreenRepository = userFavouritesScreenRepository
        showFavouritesText = true
    }
    
    // MARK: Computed Properties
    
    var marvelDataListCount: Int {
        marvelDataList?.count ?? 0
    }
    
    var favouritesScreenTitle: String {
        marvelDataType == .character ? "Characters" : "Comics"
    }
    
    // MARK: Functions
    
    func fetchAllMarvelDataFromCoreData() {
        guard let marvelDataType = marvelDataType else { return }
        guard let marvelDataList = userFavouritesScreenRepository?.fetchMarvelDataFromCoreData(marvelDataType: marvelDataType) else {
            return }
        print("marvelDataList: \(marvelDataList)")
        self.marvelDataList = marvelDataList
        
        if marvelDataList.isEmpty {
            showFavouritesText = true
        } else {
            showFavouritesText = false
        }
    }
    
    func fetchMarvelNameAndImage(for marvelIndex: Int) -> (String, String) {
        guard let marvelDataList else { return ("", "") }
        return (marvelDataList[marvelIndex].name, "\(marvelDataList[marvelIndex].thumbnail)/portrait_incredible.jpg".convertToHttps())
    }
    
    func fetchMarvelData(atIndex: Int) -> MarvelData? {
        guard let marvelDataList else { return nil}
        return marvelDataList[atIndex]
    }
    
    func set(marvelDataType: EntityType) {
        self.marvelDataType = marvelDataType
    }
}
