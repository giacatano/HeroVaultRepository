//
//  LogInViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/09.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var invalidCredentialsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invalidCredentialsLabel.isHidden = true
    }
    
    @IBAction func logInButton(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        if username == "Admin" && password == "HeroPassword"{

            performSegue(withIdentifier: "logInSegue", sender: self)
        } else {
            
            invalidCredentialsLabel.text = "Invalid Credentials"
            invalidCredentialsLabel.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        invalidCredentialsLabel.isHidden = true
    }
}
