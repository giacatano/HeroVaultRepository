//
//  AuthenticationRepository.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/04.
//

import Foundation

// MARK: Protocol

protocol AuthenticationRepositoryType {
    func signUpUser(userName: String, password: String) -> Bool
    func loginUser(userName: String, password: String) -> Bool
    func logoutUser()
}

// MARK: Repository

class AuthenticationRepository: AuthenticationRepositoryType {
    
    private var coreDataHandler = CoreDataHandler()
    
    // MARK: Authentication Functions
    
    func signUpUser(userName: String, password: String) -> Bool {
        coreDataHandler.signUpUser(userName: userName, password: password)
    }
    
    func loginUser(userName: String, password: String) -> Bool {
        coreDataHandler.loginUser(userName: userName, password: password)
    }
    
    func logoutUser() {
#warning("still doing functionality, logout")
    }
}
