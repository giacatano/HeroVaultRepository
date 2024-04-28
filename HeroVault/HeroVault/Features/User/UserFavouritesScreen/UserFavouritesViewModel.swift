//
//  UserFavouritesViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation

class UserFavouritesViewModel {
    
    private var userFavouritesRepository: UserFavouritesScreenRepositoryType?
    
    init(userFavouritesRepository: UserFavouritesScreenRepositoryType) {
        self.userFavouritesRepository = userFavouritesRepository
    }
}
