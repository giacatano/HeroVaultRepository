//
//  LoginScreenViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/04.
//

import Foundation

class LoginScreenViewModel {
    
    init(authenticationRepository: AuthenticationRepositoryType) {
        self.authenticationRepository = authenticationRepository
    }
    
    // MARK: Variables
    
    private var authenticationRepository: AuthenticationRepositoryType?
    
    // MARK: Functions
    
    func loginUser(userName: String, password: String) -> Bool {
        guard let loginUser = authenticationRepository?.loginUser(userName: userName, password: password) else { return false }
        return loginUser
    }
}
