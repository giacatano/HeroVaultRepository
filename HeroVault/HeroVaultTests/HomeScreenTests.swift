//
//  HomeScreenTests.swift
//  HeroVaultTests
//
//  Created by Gia Catano on 2024/05/06.
//

import XCTest
@testable import HeroVault

final class HomeScreenTests: XCTestCase {
    
    var viewModelUnderTests: HomeScreenViewModel!
    var mockRepository: HomeScreenRepositoryType!
    var mockDelegate: ViewModelDelegate!
    
    override func setUp() {
        
        mockRepository = MockRepository()
        mockDelegate = MockDelegate()
        viewModelUnderTests = HomeScreenViewModel(homeScreenRepository: mockRepository, delegate: mockDelegate)
    }
    
    class MockRepository: HomeScreenRepositoryType {
        
        func fetchComics(completion: @escaping (HeroVault.ComicResult) -> Void) {
            
        }
        
        func fetchCharacters(completion: @escaping (HeroVault.CharacterResult) -> Void) {
            
        }
    }
    
    class MockDelegate: ViewModelDelegate {
        
        func reloadView() {
            
        }
    }
}
    
//var marvelDataCount: Int {
//    marvelData.count
//}
//    func set(marvelDataType: EntityType) {
//        self.marvelDataType = marvelDataType
//    }
//    
//    func createImage(marvelIndex: Int) -> String {
//        "\(marvelData[marvelIndex].thumbnail)/portrait_incredible.jpg".convertToHttps()
//    }
//    
//    func fetchCharacters(atIndex: Int) -> MarvelData? {
//        marvelData[atIndex]
//    }
//    
//    func fetchMarvelData() {
//        marvelDataType == .character ? fetchCharacters() : fetchComics()
//    }
//    
//    private func fetchCharacters() {
//        marvelData = []
//        homeScreenRepository?.fetchCharacters { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let characters):
//                for character in characters.data.results {
//                    if !character.name.isEmpty && !character.overview.isEmpty && !checkIfImageIsAvailable(thumbnail: character.thumbnail) {
//                        marvelData.append(character)
//                    }
//                }
//                delegate?.reloadView()
//            case .failure(let error):
//                self.error = error
//            }
//        }
//    }
//    
//    private func fetchComics() {
//        marvelData = []
//        homeScreenRepository?.fetchComics { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let comics):
//                for comic in comics.data.results {
//                    if !comic.name.isEmpty && !checkIfImageIsAvailable(thumbnail: comic.thumbnail) {
//                        marvelData.append(comic)
//                    }
//                }
//                delegate?.reloadView()
//            case .failure(let error):
//                self.error = error
//            }
//        }
//    }
//    
//    private func checkIfImageIsAvailable(thumbnail: String) -> Bool {
//        thumbnail.contains("image_not_available")
//    }
//}
