//
//  UserFavouritesViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation

class UserFavouritesScreenViewModel: ViewModelProtocol {
    
    // MARK: Variables
    
    private var marvelDataList: [MarvelData]?
    private var userFavouritesScreenRepository: UserFavouritesScreenRepositoryType?
    private weak var delegate: ViewModelProtocol?
    private var marvelDataType: EntityType?
    var marvelData = [MarvelData]()
    
    // MARK: Functions
    
    init(userFavouritesScreenRepository: UserFavouritesScreenRepositoryType, delegate: ViewModelProtocol) {
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
    
    func createLabel(marvelDataIndex: Int) -> String {
        guard let imageLabel = (marvelDataList?[marvelDataIndex].name) else { return "" }
        return imageLabel
    }
    
    func set(marvelDataType: EntityType) {
        self.marvelDataType = marvelDataType
    }
}
