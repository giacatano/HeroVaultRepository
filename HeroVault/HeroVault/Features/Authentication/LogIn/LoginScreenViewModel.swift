//
//  LoginViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/04.
//

import Foundation

class LoginViewModel {
    
    private var authenticationRepository: AuthenticationRepositoryType?
    
    init(authenticationRepository: AuthenticationRepositoryType) {
        self.authenticationRepository = authenticationRepository
    }
    
    func loginUser(userName: String, password: String) -> Bool {
        guard let loginUser = authenticationRepository?.loginUser(userName: userName, password: password) else { return false }
        return loginUser
    }
}
