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
    var thumbnail: String { get }
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
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, thumbnail
        case overview = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        let pictures = try container.decode(Pictures.self, forKey: .thumbnail)
        thumbnail = pictures.path
    }
    
    init(id: Int, name: String, overview: String, thumbnail: String) {
        self.id = id
        self.name = name
        self.overview = overview
        self.thumbnail = thumbnail
    }
}
