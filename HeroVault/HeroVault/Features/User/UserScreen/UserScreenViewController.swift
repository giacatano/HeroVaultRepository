//
//  UserScreenViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/17.
//

import UIKit

class UserScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var userImage: UIImageView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet private weak var logoutButton: UIButton!
    
    // MARK: IBActions
    
    @IBAction private func favouriteCharactersButtonTapped(sender: Any) {
        userScreenViewModel.set(marvelDataType: .character)
        performSegue(withIdentifier: Constants.SegueIdentifierNames.userFavouritesSegueName, sender: sender)
    }
    
    @IBAction private func favouriteComicsButtonTapped(_ sender: Any) {
        userScreenViewModel.set(marvelDataType: .comic)
        performSegue(withIdentifier: Constants.SegueIdentifierNames.userFavouritesSegueName, sender: sender)
    }
    
    @IBAction private func logoutButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: Constants.SegueIdentifierNames.loginScreenSegueName, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SegueIdentifierNames.userFavouritesSegueName {
            if let userFavouritesScreen = segue.destination as? UserFavouritesScreenViewController {
                if let marvelDataType = userScreenViewModel.marvelDataType {
                    userFavouritesScreen.set(marvelDataType: marvelDataType)
                }
            }
        }
    }
}

// MARK: Variables

private var userScreenViewModel = UserScreenViewModel(authenticationRepository: AuthenticationRepository())
