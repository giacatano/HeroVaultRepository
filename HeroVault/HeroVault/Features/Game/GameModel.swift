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
    let id: Int
    let title: String
    let description: String
    let thumbnail: GamePictures
}

struct GamePictures: Codable {
    let path: String
    let jpg: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case jpg = "extension"
    }
}
