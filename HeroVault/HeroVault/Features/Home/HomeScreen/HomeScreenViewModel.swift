//
//  HomeScreenViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/03/30.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadView()
}

class HomeScreenViewModel {
    
    // MARK: Variables
    
    var marvelData = [MarvelData]()
    var marvelDataType: EntityType
    var error: Error?
    
    private let homeScreenRepository: HomeScreenRepositoryType?
    private weak var delegate: ViewModelDelegate?
    
    init(homeScreenRepository: HomeScreenRepositoryType, delegate: ViewModelDelegate) {
        self.homeScreenRepository = homeScreenRepository
        self.delegate = delegate
        self.marvelDataType = .character
    }
    
    // MARK: Computes properties
    
    var marvelDataCount: Int {
        marvelData.count
    }
    
    // MARK: Functions
    
    func set(marvelDataType: EntityType) {
        self.marvelDataType = marvelDataType
    }
    
    func createImage(marvelIndex: Int) -> String {
        "\(marvelData[marvelIndex].thumbnail)/portrait_incredible.jpg".convertToHttps()
    }
    
    func fetchCharacters(atIndex: Int) -> MarvelData? {
        marvelData[atIndex]
    }
    
    func fetchMarvelData() {
        marvelDataType == .character ? fetchCharacters() : fetchComics()
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
