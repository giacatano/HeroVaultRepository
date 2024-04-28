//
//  UserFavouritesViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/22.
//

import UIKit

class UserFavouritesViewController: UIViewController {
    // MARK: IBOutlets
    
    @IBOutlet weak private var profileLabel: UILabel!
    @IBOutlet weak private var userImage: UIImageView!
    @IBOutlet weak private var favouritesTitleLabel: UILabel!
    @IBOutlet weak private var favouritesTableView: UITableView!
    
    
    // MARK: Variables
    
    private lazy var userFavouritesViewModel = UserFavouritesViewModel(delegate: self)
    // MARK: Functions
    
    override func viewDidLoad() {
        setUpTableView()
        print("here: \(userFavouritesViewModel.showSavedCharacters())")
    }
    
    private func setUpTableView() {
        favouritesTableView.register(HomeScreenTableViewCell.characterNib(),
                                     forCellReuseIdentifier: Constants.SegueIdentifierNames.homeScreenTableViewCellName)
        favouritesTableView.dataSource = self
        favouritesTableView.delegate = self
    }
}

// MARK: Extensions

extension UserFavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
     
}

extension UserFavouritesViewController: ViewModelDelegate {
    func reloadView() {
        favouritesTableView.reloadData()
    }
}
