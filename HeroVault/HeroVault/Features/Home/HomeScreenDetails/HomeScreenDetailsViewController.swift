//
//  HomeScreenDetailsViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/18.
//

import UIKit

class HomeScreenDetailsViewController: UIViewController {
    
    private lazy var homeScreenDetailViewModel = HomeScreenDetailsViewModel(homeScreenDetailsRepository: HomeScreenDetailsRepository())
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var userRatingLabel: UILabel!
    @IBOutlet weak private var ratingImage: UIImageView!
    @IBOutlet weak private var selectedImage: UIImageView!
    @IBOutlet weak private var selectedLabel: UILabel!
    @IBOutlet weak private var descriptionTextField: UITextView!
    
    // MARK: IBActions
    
    @IBAction func starButton(_ sender: Any) {
        homeScreenDetailViewModel.saveObjectIntoCoreData()
    }
    
    // MARK: ViewController Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(homeScreenDetailViewModel.marvelData ?? "empty")
        setUpHomeScreenDetailView()
    }
    
    func set(marvelData: MarvelData) {
        homeScreenDetailViewModel.set(marvelData: marvelData)
    }
    
    private func setUpHomeScreenDetailView() {
        selectedLabel.text = homeScreenDetailViewModel.marvelDataName
        descriptionTextField.text = homeScreenDetailViewModel.marvelDataDescription
    }
}
