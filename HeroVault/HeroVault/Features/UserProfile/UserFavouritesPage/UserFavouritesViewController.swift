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
    
    // MARK: ViewController Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
