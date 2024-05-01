//
//  CharacterModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/20.
//

import Foundation

// MARK: Marvel Data Protocol

protocol MarvelData {
    var id: Int { get }
    var name: String { get }
    var overview: String { get }
}

// MARK: Character Response Model

struct CharacterResponse: Codable {
    let data: CharacterData
}

struct CharacterData: Codable {
    let results: [Character]
}

struct Character: Codable, MarvelData {
    let id: Int
    let name: String
    let overview: String
    let thumbnail: CharacterPictures
    
    enum CodingKeys: String, CodingKey {
        case id, name, thumbnail
        case overview = "description"
    }
}

struct CharacterPictures: Codable {
    let path: String
    let jpg: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case jpg = "extension"
    }
}
