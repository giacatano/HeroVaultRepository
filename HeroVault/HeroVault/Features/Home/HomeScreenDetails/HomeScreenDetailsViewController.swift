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
    @IBOutlet weak private var discoverLabel: UILabel!
    @IBOutlet weak private var selectedImage: UIImageView!
    @IBOutlet weak private var selectedLabel: UILabel!
    @IBOutlet weak private var descriptionTextField: UITextView!
    @IBOutlet weak private var whiteCardImageView: UIImageView!
    
    // MARK: IBActions
    
    @IBAction func starButton(_ sender: Any) {
        homeScreenDetailViewModel.saveObjectIntoCoreData()
    }
    
    // MARK: ViewController Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whiteCardImageView.layer.cornerRadius = 10
        print(homeScreenDetailViewModel.character ?? "empty")
        setUpHomeScreenDetailView()
    }
    
    func set(character: Character) {
        homeScreenDetailViewModel.set(character: character)
    }
    
    private func setUpHomeScreenDetailView() {
        selectedLabel.text = homeScreenDetailViewModel.characterName
        descriptionTextField.text = homeScreenDetailViewModel.characterDescription
    }
}
