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
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var favouriteCharactersLabel: UILabel!
    @IBOutlet private weak var favouriteCharactersStarImage: UIImageView!
    @IBOutlet private weak var favouriteComicsLabel: UILabel!
    @IBOutlet private weak var favouriteComicsStarImage: UIImageView!

// MARK: IBActions
    
    @IBAction func favouriteCharactersButton(sender: Any) {
        performSegue(withIdentifier: Constants.SegueIdentifierNames.userFavouritesSegueName, sender: sender)
    }
    @IBAction func favouriteComicsButton(_ sender: Any) {
        performSegue(withIdentifier: Constants.SegueIdentifierNames.userFavouritesSegueName, sender: sender)
    }

// MARK: ViewController Functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

