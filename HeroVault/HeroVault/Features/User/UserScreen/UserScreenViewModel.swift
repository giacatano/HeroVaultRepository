//
//  UserScreenViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation

class UserScreenViewModel {
    
    init(authenticationRepository: AuthenticationRepositoryType) {
        self.authenticationRepository = authenticationRepository
    }
    
    // MARK: Variables
    
    private var authenticationRepository: AuthenticationRepositoryType?
    var marvelDataType: EntityType?
    
    // MARK: Functions
    
    func set(marvelDataType: EntityType) {
        self.marvelDataType = marvelDataType
    }
}
