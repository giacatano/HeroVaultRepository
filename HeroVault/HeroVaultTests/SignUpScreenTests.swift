//
//  SignUpScreenTests.swift
//  HeroVaultTests
//
//  Created by Gia Catano on 2024/05/08.
//

import XCTest
@testable import HeroVault

class SignUpScreenViewModelTests: XCTestCase {
    var viewModel: SignUpScreenViewModel!
    var mockRepository: MockSignUpAuthenticationRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockSignUpAuthenticationRepository()
        viewModel = SignUpScreenViewModel(authenticationRepository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testSignUpUserSuccess() {
        let username = "testUser"
        let password = "testPassword"
        
        mockRepository.signUpUserResult = true
        let result = viewModel.signUpUser(userName: username, password: password)
        XCTAssertTrue(result)
    }
    
    func testSignUpUserFailure() {
        let username = "testUser"
        let password = "testPassword"
        
        mockRepository.signUpUserResult = false
        let result = viewModel.signUpUser(userName: username, password: password)
        XCTAssertFalse(result)
    }
}

// MARK: Mock Classes

class MockSignUpAuthenticationRepository: AuthenticationRepositoryType {
    var signUpUserResult: Bool?
    
    func signUpUser(userName: String, password: String) -> Bool {
        return signUpUserResult ?? false
    }
    
    func loginUser(userName: String, password: String) -> Bool {
        return true
    }
}
