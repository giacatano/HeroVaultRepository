//
//  LogInViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/09.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var invalidCredentialsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invalidCredentialsLabel.isHidden = true
    }
    
    // MARK: IBActions
    
    @IBAction func logInButton(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if username == "" && password == "" {
            performSegue(withIdentifier: Constants.SegueIdentifierNames.loginScreenSegueName, sender: self)
        } else {
            invalidCredentialsLabel.text = "Invalid Credentials"
            invalidCredentialsLabel.isHidden = false
        }
    }
}
