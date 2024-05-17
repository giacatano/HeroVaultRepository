//
//  UserScreenViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation

class UserScreenViewModel {
    
    // MARK: Variables
    
    private var authenticationRepository: AuthenticationRepositoryType?
    var marvelDataType: EntityType?
    
    init(authenticationRepository: AuthenticationRepositoryType) {
        self.authenticationRepository = authenticationRepository
    }
    
    // MARK: Functions
    
    func set(marvelDataType: EntityType) {
        self.marvelDataType = marvelDataType
    }
    
    func logout() {
        authenticationRepository?.logoutUser()
    }
    
}
