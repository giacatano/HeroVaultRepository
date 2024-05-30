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
        static let marvelComicNames = "https://gateway.marvel.com:443/v1/public/comics"
        static let marvelEvents = "https://gateway.marvel.com:443/v1/public/events"
    }
    
    struct APIKeys {
        static let privateAPIKey = "73a28de7a8768594dd2e68edda1d36370c08290b"
        static let publicAPIKey = "8b210265935b59224adf09a480932131"
    }
    
    struct SegueIdentifierNames {
        static let homeScreenDetailSegueName = "SearchDetailsSegue"
        static let homeScreenTableViewCellName = "HomeScreenTableViewCell"
        static let loginScreenSegueName = "LoginScreenSegue"
        static let userFavouritesSegueName = "UserFavouritesSegue"
        static let userFavouritesScreenCollectionViewCellName = "UserFavouritesScreenCollectionViewCell"
        static let signUpScreenSegueName = "SignUpScreenSegue"
        static let gameScreenCollectionViewCellName = "GameScreenCollectionViewCell"
    }
    
    struct CoreData {
        static let characterEntityName = "CoreDataCharacter"
        static let comicEntityName = "CoreDataComic"
        static let persistentContainerName = "CoreData"
    }
    
    struct ErrorManagement {
        static let descriptionError = "It is thought that there are around 37,000 Marvel comics. If you took 15 minutes to read each comic, and you devoted eight hours of your day, every day, to the adventures of the superhero squad, it would take you approximately 1,156 days to complete the series."
        static let existingUserError = "User already exists"
        static let invalidCredentialsError = "Invalid Credentials"
    }
    
    struct Storyboards {
        static let loginScreenViewController = "LoginScreenViewController"
        static let loginScreen = "LoginScreen"
    }
    
    struct ApplicationText {
        static let highScoreTitle = "New High Score"
        static let highScoreMessage = "Your new high score is: "
        static let gameOverTitle = "Game Over"
        static let gameOverMessage = "Your score was: "
    }
}
