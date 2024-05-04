//
//  UserFavouritesViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation

class UserFavouritesScreenViewModel: ViewModelDelegate {
    
    // MARK: Variables
    
    private var marvelDataList: [MarvelData]?
    private var userFavouritesScreenRepository: UserFavouritesScreenRepositoryType?
    private weak var delegate: ViewModelDelegate?
    private var marvelDataType: EntityType?
    
    // MARK: Functions
    
    init(userFavouritesScreenRepository: UserFavouritesScreenRepositoryType, delegate: ViewModelDelegate) {
        self.userFavouritesScreenRepository = userFavouritesScreenRepository
        self.delegate = delegate
    }
    
    var marvelDataListCount: Int {
        marvelDataList?.count ?? 0
    }
    
    var favouritesScreenTitle: String {
        marvelDataType == .character ? "Characters" : "Comics"
    }
    
    func fetchAllMarvelDataFromCoreData() {
        guard let marvelDataType = marvelDataType else { return }
        guard let marvelDataList = userFavouritesScreenRepository?.fetchMarvelDataFromCoreData(marvelDataType: marvelDataType) else { return }
        print("marvelDataList: \(marvelDataList)")
        self.marvelDataList = marvelDataList
    }
    
    func fetchAllNamesOfCharactersInCoreData() -> [String] {
        guard let names = userFavouritesScreenRepository?.fetchNames() else { return [] }
        return names
    }
    
    func reloadView() {
    }
    
    func createImage(marvelDataIndex: Int) -> String {
        guard var imageName = (marvelDataList?[marvelDataIndex].thumbnail) else { return "" }
        imageName.append("/portrait_incredible.jpg")
        return imageName.convertToHttps()
    }
    
    func set(marvelDataType: EntityType) {
        self.marvelDataType = marvelDataType
    }
}
