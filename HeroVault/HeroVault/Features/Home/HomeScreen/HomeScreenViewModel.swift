//
//  HomeScreenViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/03/30.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    func reloadView()
}

class HomeScreenViewModel {
    
    // MARK: Variables
    
    var marvelData = [MarvelData]()
    var filteredMarvelData = [MarvelData]()
    var marvelDataType: EntityType
    var error: Error?
    var isSearching: Bool
    
    private let homeScreenRepository: HomeScreenRepositoryType?
    private weak var delegate: ViewModelProtocol?
    
    init(homeScreenRepository: HomeScreenRepositoryType, delegate: ViewModelProtocol) {
        self.homeScreenRepository = homeScreenRepository
        self.delegate = delegate
        self.marvelDataType = .character
        isSearching = false
    }
    
    // MARK: Computes properties
    
    var marvelDataCount: Int {
        marvelData.count
    }
    
    var filteredMarvelDataCount: Int {
        filteredMarvelData.count
    }
    
    var numberOfSections: Int {
        isSearching ? filteredMarvelDataCount : marvelDataCount
    }
    
    // MARK: Functions
    
    func set(marvelDataType: EntityType) {
        self.marvelDataType = marvelDataType
    }
    
    func fetchMarvelNameAndImage(for marvelIndex: Int) -> (String, String) {
        isSearching ?
        (filteredMarvelData[marvelIndex].name, "\(filteredMarvelData[marvelIndex].thumbnail)/portrait_incredible.jpg".convertToHttps()) :
        (marvelData[marvelIndex].name, "\(marvelData[marvelIndex].thumbnail)/portrait_incredible.jpg".convertToHttps())
    }
    
    func fetchMarvelData(atIndex: Int) -> MarvelData? {
        isSearching ? filteredMarvelData[atIndex] : marvelData[atIndex]
    }
    
    func fetchMarvelData() {
        marvelDataType == .character ? fetchCharacters() : fetchComics()
    }
    
    func filterMarvelData(filteredText: String) {
        isSearching = true
        guard !filteredText.isEmpty else {
            isSearching = false
            return
        }
        
        filteredMarvelData = marvelData.filter { marvelItem in
            marvelItem.name.lowercased().contains(filteredText.lowercased())
        }
        delegate?.reloadView()
    }
    
    func handleSegmentedControl(segmentedCotrolTitle: String) {
        isSearching = false
        segmentedCotrolTitle == "Characters" ? set(marvelDataType: EntityType.character) : set(marvelDataType: EntityType.comic)
        fetchMarvelData()
    }
    
    private func fetchCharacters() {
        marvelData = []
        homeScreenRepository?.fetchCharacters { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let characters):
                for character in characters.data.results {
                    if !character.name.isEmpty && !character.overview.isEmpty && !checkIfImageIsAvailable(thumbnail: character.thumbnail) {
                        marvelData.append(character)
                    }
                }
                delegate?.reloadView()
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    private func fetchComics() {
        marvelData = []
        homeScreenRepository?.fetchComics { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let comics):
                for comic in comics.data.results {
                    if !comic.name.isEmpty && !checkIfImageIsAvailable(thumbnail: comic.thumbnail) {
                        marvelData.append(comic)
                    }
                }
                delegate?.reloadView()
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    private func checkIfImageIsAvailable(thumbnail: String) -> Bool {
        thumbnail.contains("image_not_available")
    }
}
