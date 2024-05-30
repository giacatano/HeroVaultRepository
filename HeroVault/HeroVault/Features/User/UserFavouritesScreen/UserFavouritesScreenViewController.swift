//
//  UserFavouritesScreenViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/22.
//

import UIKit

class UserFavouritesScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var userImage: UIImageView!
    @IBOutlet weak private var favouritesTitleLabel: UILabel!
    @IBOutlet weak private var favouritesCollectionView: UICollectionView!
    @IBOutlet weak private var noFavouritesLabel: UILabel!
    
    // MARK: Variables
    
    private lazy var userFavouritesScreenViewModel = UserFavouritesScreenViewModel(userFavouritesScreenRepository:
                                                                                    UserFavouritesScreenRepository(), delegate: self)
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpScreen()
    }
    
    func setUpScreen() {
        userFavouritesScreenViewModel.fetchAllMarvelDataFromCoreData()
        favouritesTitleLabel.text = userFavouritesScreenViewModel.favouritesScreenTitle
        noFavouritesLabel.isHidden = !userFavouritesScreenViewModel.showFavouritesText
    }
    
    func set(marvelDataType: EntityType) {
        userFavouritesScreenViewModel.set(marvelDataType: marvelDataType)
    }
    
    private func setUpCollectionView() {
        favouritesCollectionView.register(UserFavouritesScreenCollectionViewCell.characterNib(),
                                          forCellWithReuseIdentifier:
                                            Constants.SegueIdentifierNames.userFavouritesScreenCollectionViewCellName)
        favouritesCollectionView.dataSource = self
        favouritesCollectionView.delegate = self
    }
}

// MARK: Extensions

extension UserFavouritesScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.SegueIdentifierNames.homeScreenDetailSegueName, sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userFavouritesScreenViewModel.marvelDataListCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 180, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let favouritesScreenCollectionViewCell =
                favouritesCollectionView.dequeueReusableCell(withReuseIdentifier:
                                                                Constants.SegueIdentifierNames.userFavouritesScreenCollectionViewCellName,
                                                             for: indexPath) as? UserFavouritesScreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let (marvelName, marvelImage) = userFavouritesScreenViewModel.fetchMarvelNameAndImage(for: indexPath.row)
        favouritesScreenCollectionViewCell.setUpNib(marvelName: marvelName, marvelImage: marvelImage)
        favouritesScreenCollectionViewCell.layer.cornerRadius = 5
        return favouritesScreenCollectionViewCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath,
           segue.identifier == Constants.SegueIdentifierNames.homeScreenDetailSegueName {
            if let homeScreenDetailScreen = segue.destination as? HomeScreenDetailsViewController {
                if let marvelData = userFavouritesScreenViewModel.fetchMarvelData(atIndex: indexPath.row) {
                    homeScreenDetailScreen.set(marvelData: marvelData)
                }
            }
        }
    }
}

extension UserFavouritesScreenViewController: ViewModelProtocol {
    func stopLoadingIndicator() {
    }
    
    func reloadView() {
        favouritesCollectionView.reloadData()
    }
    
    func startLoadingIndicator() {
    }
    
    func showError(title: String, message: String) {
    }
    
    func showSuccess(title: String, message: String) {
    }
}
