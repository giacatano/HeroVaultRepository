//
//  SignUpViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/04.
//

import Foundation

class SignUpViewModel {
    
    private var authenticationRepository: AuthenticationRepositoryType?
    
    init(authenticationRepository: AuthenticationRepositoryType) {
        self.authenticationRepository = authenticationRepository
    }
    
    func signUpUser(userName: String, password: String) -> Bool {
        guard let signUpuser = authenticationRepository?.signUpUser(userName: userName, password: password) else { return false }
        return signUpuser
    }
}
