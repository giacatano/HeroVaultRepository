//
//  GameModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/20.
//

import Foundation

// MARK: Game Response Model

struct GameResponse: Codable {
    let data: GameData
}

struct GameData: Codable {
    let results: [Game]
}

struct Game: Codable {
    let overview: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case thumbnail
        case overview = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        let pictures = try container.decode(Pictures.self, forKey: .thumbnail)
        thumbnail = pictures.path
    }
}
