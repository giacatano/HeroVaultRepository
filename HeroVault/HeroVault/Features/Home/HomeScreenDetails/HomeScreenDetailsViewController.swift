//
//  HomeScreenDetailsViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/18.
//

import UIKit

class HomeScreenDetailsViewController: UIViewController {
    
    private lazy var homeScreenDetailViewModel = HomeScreenDetailsViewModel(homeScreenDetailsRepository: HomeScreenDetailsRepository(coreDataHandler: CoreDataHandler()))
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var userRatingLabel: UILabel!
    @IBOutlet weak private var ratingImage: UIImageView!
    @IBOutlet weak private var selectedImage: UIImageView!
    @IBOutlet weak private var selectedLabel: UILabel!
    @IBOutlet weak private var descriptionTextField: UITextView!
    @IBOutlet weak private var starButton: UIButton!
    
    // MARK: IBActions
    
    @IBAction private func starButtonTapped(_ sender: Any) {
        setUpFavouritedButton()
    }
    
    // MARK: View Controller Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHomeScreenDetailView()
        homeScreenDetailViewModel.hasObjectBeenFavourited() ? starButton.setImage(UIImage(systemName: "star.circle.fill"), for: .normal) : starButton.setImage(UIImage(systemName: "star.circle"), for: .normal)
    }
    
    func set(marvelData: MarvelData) {
        homeScreenDetailViewModel.set(marvelData: marvelData)
    }
    
    private func setUpHomeScreenDetailView() {
        selectedLabel.text = homeScreenDetailViewModel.marvelDataName
        descriptionTextField.text = homeScreenDetailViewModel.marvelDataDescription
        selectedImage.load(urlString: homeScreenDetailViewModel.createImage())
    }
    
    private func setUpFavouritedButton() {
        let isFavourited = homeScreenDetailViewModel.hasObjectBeenFavourited()
        let imageName = isFavourited ? "star.circle" : "star.circle.fill"
        starButton.setImage(UIImage(systemName: imageName), for: .normal)
        isFavourited ? homeScreenDetailViewModel.removeFromFavourites() : homeScreenDetailViewModel.saveObjectIntoCoreData()
    }
}
