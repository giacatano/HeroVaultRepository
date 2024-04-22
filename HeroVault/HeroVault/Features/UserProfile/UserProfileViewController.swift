//
//  UserProfileViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/17.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var profileLabel: UILabel!
    @IBOutlet weak private var userImage: UIImageView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var favouriteCharactersLabel: UILabel!
    @IBOutlet weak private var favouriteCharactersStarImage: UIImageView!
    @IBOutlet weak private var favouriteComicsLabel: UILabel!
    @IBOutlet weak private var favouriteComicsStarImage: UIImageView!

// MARK: IBActions
    
    @IBAction private func favouriteCharactersButton(sender: Any) {
        performSegue(withIdentifier: Constants.SegueIdentifierNames.userFavouritesSegueName, sender: sender)
    }
    @IBAction private func favouriteComicsButton(_ sender: Any) {
        performSegue(withIdentifier: Constants.SegueIdentifierNames.userFavouritesSegueName, sender: sender)
    }

// MARK: ViewController Functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

