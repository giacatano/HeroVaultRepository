//
//  SearchCharactersRepository.swift
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
        apiHandler.request(path: Constants.EndPoints.marvelCharacterNames, networkType: NetworkingRequestType.GET, model: CharacterResponse.self) { result in
            completion(result)
        }
    }    
}

// MARK: Character Response Model
struct CharacterResponse: Codable {
    let data: CharacterData
}

struct CharacterData: Codable {
    let results: [Characters]
}

struct Characters: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: CharacterPictures
}

struct CharacterPictures: Codable {
    let path: String
    let jpg: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case jpg = "extension"
    }
}
