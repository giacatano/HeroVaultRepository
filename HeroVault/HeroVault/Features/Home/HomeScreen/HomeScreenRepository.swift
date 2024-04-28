//
//  ComicRepository.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/02.
//

import Foundation

// MARK: Typealias

typealias ComicResult = Result<ComicResponse, NetworkingError>
typealias CharacterResult = Result<CharacterResponse, NetworkingError>

// MARK: Protocol

protocol HomeScreenRepositoryType {
    func fetchComics(completion: @escaping (ComicResult) -> Void)
    func fetchCharacters(completion: @escaping (CharacterResult) -> Void)
}

// MARK: Repository

class HomeScreenRepository: HomeScreenRepositoryType {
    
    private let apiHandler = APIHandler()
    
    func fetchComics(completion: @escaping (ComicResult) -> Void) {
        apiHandler.request(path: Constants.EndPoints.marvelComicTitles,
                           networkType: NetworkingRequestType.GET,
                           model: ComicResponse.self) { result in
            completion(result)
        }
    }
    
    func fetchCharacters(completion: @escaping (CharacterResult) -> Void) {
        apiHandler.request(path: Constants.EndPoints.marvelCharacterNames,
                           networkType: NetworkingRequestType.GET,
                           model: CharacterResponse.self) { result in
            completion(result)
        }
    }
}
