//
//  CharacterRepository.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/03/30.
//

import Foundation

typealias CharacterResult = Result<CharacterResponse, NetworkingError>

protocol CharacterRepositoryType {
    func fetchCharacters(completion: @escaping (CharacterResult) -> Void)
}

class CharacterRepository: CharacterRepositoryType {
    
    private let apiHandler = APIHandler()
    
    func fetchCharacters(completion: @escaping (CharacterResult) -> Void) {
        apiHandler.request(path: Constants.EndPoints.marvelCharacterNames,
                           networkType: NetworkingRequestType.GET,
                           model: CharacterResponse.self) { result in
            completion(result)
        }
    }
}
