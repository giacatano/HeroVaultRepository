//
//  LoginScreenTests.swift
//  HeroVaultTests
//
//  Created by Gia Catano on 2024/05/08.
//

import XCTest
@testable import HeroVault

class LoginScreenViewModelTests: XCTestCase {
    var viewModel: LoginScreenViewModel!
    var mockRepository: MockLoginAuthenticationRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockLoginAuthenticationRepository()
        viewModel = LoginScreenViewModel(authenticationRepository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testLoginUser_Success() {
        let username = "testUser"
        let password = "testPassword"
        
        mockRepository.loginUserResult = true

        let result = viewModel.loginUser(userName: username, password: password)
        XCTAssertTrue(result)
    }
    
    func testLoginUser_Failure() {
        let username = "testUser"
        let password = "testPassword"
        
        mockRepository.loginUserResult = false

        let result = viewModel.loginUser(userName: username, password: password)
        XCTAssertFalse(result)
    }
}

// MARK: Mock Classes

class MockLoginAuthenticationRepository: AuthenticationRepositoryType {
    var loginUserResult: Bool?
    
    func signUpUser(userName: String, password: String) -> Bool {
        return true
    }
    
    func loginUser(userName: String, password: String) -> Bool {
        return loginUserResult ?? false
    }
}
