//
//  CharacterModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/20.
//

import Foundation

// MARK: Character Response Model

struct CharacterResponse: Codable {
    let data: CharacterData
}

struct CharacterData: Codable {
    let results: [Character]
}

struct Character: Codable, Test {
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
