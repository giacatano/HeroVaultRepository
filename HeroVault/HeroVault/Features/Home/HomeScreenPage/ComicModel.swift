//
//  ComicModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/20.
//

import Foundation

// MARK: Comic Response Model
protocol Test {
    var id: Int { get }
    var name: String { get }
    var description: String { get }
}
struct ComicResponse: Codable {
    let data: ComicData
}

struct ComicData: Codable {
    let results: [Comic]
}

struct Comic: Codable, Test {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ComicPictures
}

struct ComicPictures: Codable {
    let path: String
    let jpg: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case jpg = "extension"
    }
}
