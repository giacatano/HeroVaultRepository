//
//  SignUpViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/04.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private lazy var signUpViewModel = SignUpViewModel(authenticationRepository: AuthenticationRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
