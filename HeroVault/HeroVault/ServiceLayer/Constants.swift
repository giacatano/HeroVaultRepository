//
//  Constants.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/03/30.
//

import Foundation

struct Constants {
    
    struct EndPoints {
        static let marvelCharacterNames = "https://gateway.marvel.com:443/v1/public/characters"
        static let marvelComicTitles = "https://gateway.marvel.com:443/v1/public/comics"
        static let marvelStoryDescriptions = "https://gateway.marvel.com:443/v1/public/events"
    }
    
    struct APIKeys {
        static let privateAPIKey = "73a28de7a8768594dd2e68edda1d36370c08290b"
        static let publicAPIKey = "8b210265935b59224adf09a480932131"
    }
    
    struct SegueIdentifierNames {
        static let homeScreenDetailSegueName = "SearchDetailsSegue"
        static let homeScreenTableViewCellName = "HomeScreenTableViewCell"
    }
}
