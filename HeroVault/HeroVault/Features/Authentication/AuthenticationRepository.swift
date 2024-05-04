//
//  AuthenticationRepository.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/04.
//

import Foundation

protocol AuthenticationRepositoryType {
    func createUser(userName: String, password: String) -> Bool
    func loginUser(userName: String, password: String) -> Bool
}

class AuthenticationRepository: AuthenticationRepositoryType {
    
    private var coreDataHandler = CoreDataHandler()
    
    // MARK: Authentication Functions
    
    func createUser(userName: String, password: String) -> Bool {
        coreDataHandler.createUser(userName: userName, password: password)
    }
    
    func loginUser(userName: String, password: String) -> Bool {
        coreDataHandler.loginUser(userName: userName, password: password)
    }
}
