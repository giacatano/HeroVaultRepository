//
//  SignUpScreenViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/04.
//

import Foundation

class SignUpScreenViewModel {
    
    init(authenticationRepository: AuthenticationRepositoryType) {
        self.authenticationRepository = authenticationRepository
    }
    
    // MARK: Variables
    
    private var authenticationRepository: AuthenticationRepositoryType?
    
    // MARK: Functions
    
    func signUpUser(userName: String, password: String) -> Bool {
        guard let signUpUser = authenticationRepository?.signUpUser(userName: userName, password: password) else { return false }
        return signUpUser
    }
}
