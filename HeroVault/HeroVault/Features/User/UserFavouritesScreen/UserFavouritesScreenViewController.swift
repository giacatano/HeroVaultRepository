//
//  UserFavouritesScreenViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/22.
//

import UIKit

class UserFavouritesScreenViewController: UIViewController, ViewModelDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var profileLabel: UILabel!
    @IBOutlet weak private var userImage: UIImageView!
    @IBOutlet weak private var favouritesTitleLabel: UILabel!
    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    
    // MARK: Variables
    
    private lazy var userFavouritesViewModel = UserFavouritesViewModel(userFavouritesRepository: UserFavouritesScreenRepository(), delegate: self)
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectinView()
        favouritesCollectionView.dataSource = self
        favouritesCollectionView.delegate = self
    }
    
    private func setUpCollectinView() {
        favouritesCollectionView.register(HomeScreenTableViewCell.characterNib(), forCellWithReuseIdentifier: Constants.SegueIdentifierNames.homeScreenTableViewCellName)

    }
    
    func reloadView() {
        favouritesCollectionView.reloadData()
    }
}

// MARK: Extensions

extension UserFavouritesScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        favouritesCollectionView.deselectItem(at: indexPath, animated: true)
        
        print("You selcted me")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let favouritesCell = favouritesCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.SegueIdentifierNames.homeScreenTableViewCellName,
                                                                                for: indexPath) as? HomeScreenTableViewCell else {
            return UICollectionViewCell()
        }
        
        favouritesCell.setUpNib(imageName: imageName, imageURL: imageURL)
        return favouritesCell
    }
}
// TODO: Setup collection view
