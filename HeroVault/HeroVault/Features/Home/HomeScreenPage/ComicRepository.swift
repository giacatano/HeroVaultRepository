//
//  ComicRepository.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/02.
//

import Foundation

typealias ComicResult = Result<ComicResponse, NetworkingError>

protocol ComicRepositoryType {
    func fetchComics(completion: @escaping (ComicResult) -> Void)
}

class ComicRepository: ComicRepositoryType {
    
    private let apiHandler = APIHandler()
    
    func fetchComics(completion: @escaping (ComicResult) -> Void) {
        apiHandler.request(path: Constants.EndPoints.marvelComicTitles,
                           networkType: NetworkingRequestType.GET,
                           model: ComicResponse.self) { result in
            completion(result)
        }
    }
}
