//
//  ComicModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/20.
//

import Foundation

// MARK: Comic Response Model

struct ComicResponse: Codable {
    let data: ComicData
}

struct ComicData: Codable {
    let results: [Comic]
}

struct Comic: Codable, MarvelData {
    let id: Int
    let name: String
    let overview: String
    let thumbnail: String
    let isFavourited: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, thumbnail
        case name = "title"
        case overview = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        let pictures = try container.decode(Pictures.self, forKey: .thumbnail)
        thumbnail = pictures.path
        isFavourited = false
    }
    
    init(id: Int, name: String, overview: String, thumbnail: String, isFavourited: Bool) {
        self.id = id
        self.name = name
        self.overview = overview
        self.thumbnail = thumbnail
        self.isFavourited = isFavourited
    }
}

struct Pictures: Codable {
    let path: String
}
