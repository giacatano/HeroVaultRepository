//
//  SignUpScreenViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/04.
//

import UIKit

class SignUpScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var userNameTestField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var usernameWarningLabel: UILabel!
    
    // MARK: IBActions
    
    @IBAction private func signUpButtonTapped(_ sender: Any) {
        let username = userNameTestField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if signUpScreenViewModel.signUpUser(userName: username, password: password) {
            performSegue(withIdentifier: Constants.SegueIdentifierNames.loginScreenSegueName, sender: sender)
        } else {
            invalidSignUp()
        }
    }
    
    @IBAction private func logInButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: Constants.SegueIdentifierNames.loginScreenSegueName, sender: sender)
    }
    
    // MARK: Variables
    
    private lazy var signUpScreenViewModel = SignUpScreenViewModel(authenticationRepository: AuthenticationRepository())
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSignUpScreen()
    }
    
    private func setUpSignUpScreen() {
        usernameWarningLabel.isHidden = true
        hideKeyboardWhenTappedAround()
    }
    
    private func invalidSignUp() {
        usernameWarningLabel.isHidden = false
        usernameWarningLabel.text = Constants.ErrorManagement.existingUserError
        userNameTestField.text = ""
        passwordTextField.text = ""
    }
}
