//
//  LoginScreenViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/09.
//

import UIKit

class LoginScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var invalidCredentialsLabel: UILabel!
    
    // MARK: IBActions
    
    @IBAction private func signUpButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: Constants.SegueIdentifierNames.signUpScreenSegueName, sender: sender)
    }
    
    @IBAction private func logInButton(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if loginScreenViewModel.loginUser(userName: username, password: password) {
            performSegue(withIdentifier: Constants.SegueIdentifierNames.loginScreenSegueName, sender: self)
        } else {
            invalidLogin()
        }
    }
    
    private lazy var loginScreenViewModel = LoginScreenViewModel(authenticationRepository: AuthenticationRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLoginScreen()
    }
    
    private func setUpLoginScreen() {
        invalidCredentialsLabel.isHidden = true
    }
    
    private func invalidLogin() {
        invalidCredentialsLabel.isHidden = false
        invalidCredentialsLabel.text = "Invalid Credentials"
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
}
