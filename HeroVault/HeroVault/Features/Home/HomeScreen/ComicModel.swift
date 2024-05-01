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
    let thumbnail: ComicPictures
    
    enum CodingKeys: String, CodingKey {
        case id, thumbnail
        case name = "title"
        case overview = "description"
    }
}

struct ComicPictures: Codable {
    let path: String
    let jpg: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case jpg = "extension"
    }
}
