//
//  UserFavouritesScreenViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/22.
//

import UIKit

class UserFavouritesScreenViewController: UIViewController, ViewModelDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var starImageView: UIImageView!
    @IBOutlet weak private var profileLabel: UILabel!
    @IBOutlet weak private var userImage: UIImageView!
    @IBOutlet weak private var favouritesTitleLabel: UILabel!
    @IBOutlet weak private var favouritesCollectionView: UICollectionView!
    
    // MARK: Variables
    
    private lazy var userFavouritesScreenViewModel = UserFavouritesScreenViewModel(userFavouritesScreenRepository: UserFavouritesScreenRepository(), delegate: self)
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        userFavouritesScreenViewModel.fetchAllCharactersFromCoreData()
        userFavouritesScreenViewModel.fetchAllNamesOfCharactersInCoreData()
    }
    
    private func setUpCollectionView() {
        favouritesCollectionView.register(UserFavouritesScreenCollectionViewCell.characterNib(),
                                          forCellWithReuseIdentifier: Constants.SegueIdentifierNames.userFavouritesScreenCollectionViewCellName)
        favouritesCollectionView.dataSource = self
        favouritesCollectionView.delegate = self
    }
    
    func reloadView() {
        favouritesCollectionView.reloadData()
    }
}

// MARK: Extensions

extension UserFavouritesScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        favouritesCollectionView.deselectItem(at: indexPath, animated: true)
        print("You selcted me")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let favouritesScreenCollectionViewCell = favouritesCollectionView.dequeueReusableCell(withReuseIdentifier:
                                                                                                        Constants.SegueIdentifierNames.userFavouritesScreenCollectionViewCellName,
                                                                                                    for: indexPath) as? UserFavouritesScreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let imageName = userFavouritesScreenViewModel.createImage(characterIndex: indexPath.row)
        favouritesScreenCollectionViewCell.setUpImage(with: UIImage(imageLiteralResourceName: "Spiderman.png"), name: "Spiderman")
        favouritesScreenCollectionViewCell.layer.cornerRadius = 10
        
        return favouritesScreenCollectionViewCell
    }
}
