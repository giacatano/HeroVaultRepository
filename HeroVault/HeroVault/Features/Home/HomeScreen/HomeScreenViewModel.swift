//
//  HomeScreenViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/03/30.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    func reloadView()
    func startLoadingIndicator()
    func stopLoadingIndicator()
    func showError(title: String, message: String)
    func showSuccess(title: String, message: String)
}

class HomeScreenViewModel {
    
    // MARK: Variables
    
    var hideNoResultsText: Bool
    private var marvelData = [MarvelData]()
    private var filteredMarvelData = [MarvelData]()
    private var marvelDataType: EntityType
    private var error: Error?
    var isSearching: Bool
    private let homeScreenRepository: HomeScreenRepositoryType?
    private weak var delegate: ViewModelProtocol?
    
    init(homeScreenRepository: HomeScreenRepositoryType, delegate: ViewModelProtocol) {
        self.homeScreenRepository = homeScreenRepository
        self.delegate = delegate
        self.marvelDataType = .character
        isSearching = false
        hideNoResultsText = true
    }
    
    // MARK: Computed Properties
    
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
            hideNoResultsText = true
            return
        }
        
        filteredMarvelData = marvelData.filter { marvelItem in
            marvelItem.name.lowercased().contains(filteredText.lowercased())
        }
        
        loadSearchNotFoundText()
        delegate?.reloadView()
    }
    
    func handleSegmentedControl(segmentedControlTitle: String) {
        isSearching = false
        segmentedControlTitle == "Characters" ? set(marvelDataType: EntityType.character) : set(marvelDataType: EntityType.comic)
        fetchMarvelData()
    }
    
    private func fetchCharacters() {
        delegate?.startLoadingIndicator()
        marvelData = []
        homeScreenRepository?.fetchCharacters { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let characters):
                for character in characters.data.results {
                    if !character.name.isEmpty && !character.overview.isEmpty && !isImageAvailable(thumbnail: character.thumbnail) {
                        marvelData.append(character)
                    }
                }
                delegate?.reloadView()
            case .failure(let error):
                self.error = error
            }
            delegate?.stopLoadingIndicator()
        }
    }
    
    private func fetchComics() {
        delegate?.startLoadingIndicator()
        marvelData = []
        homeScreenRepository?.fetchComics { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let comics):
                for comic in comics.data.results {
                    if !comic.name.isEmpty && !isImageAvailable(thumbnail: comic.thumbnail) {
                        marvelData.append(comic)
                    }
                }
                delegate?.reloadView()
            case .failure(let error):
                self.error = error
            }
            delegate?.stopLoadingIndicator()
        }
    }
    
    private func isImageAvailable(thumbnail: String) -> Bool {
        thumbnail.contains("image_not_available")
    }
    
    private func loadSearchNotFoundText() {
        hideNoResultsText = !filteredMarvelData.isEmpty
    }
}
