//
//  HomeScreenDetailsViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/18.
//

import UIKit

class HomeScreenDetailsViewController: UIViewController {
    
    private lazy var homeScreenDetailViewModel = HomeScreenDetailsViewModel()
    private var test = CoreDataHandler()
    
    // MARK: IBOutlets
    @IBOutlet weak private var mainStackView: UIStackView!
    @IBOutlet weak private var userRatingLabel: UILabel!
    @IBOutlet weak private var ratingImage: UIImageView!
    @IBOutlet weak private var discoverLabel: UILabel!
    @IBOutlet weak private var selectedImage: UIImageView!
    @IBOutlet weak private var selectedLabel: UILabel!
    @IBOutlet weak private var descriptionTextField: UITextView!
    
    // MARK: IBActions
    
    @IBAction func starButton(_ sender: Any) {
        let test = Characters(context: test.context)
        test.id = homeScreenDetailViewModel.characterID
        test.name = homeScreenDetailViewModel.characterName
        test.overview = homeScreenDetailViewModel.characterDescription
        
            self.test.saveContext()
            self.test.getAllCharacters()
        
        print("Saved: \(self.test.getAllCharacters())")
            
    }
    
    // MARK: ViewController Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainStackView.layer.cornerRadius = 10
        print(homeScreenDetailViewModel.character ?? "empty")
        setUpHomeScreenDetailView()
    }
    
    func set(character: Test) {
        homeScreenDetailViewModel.set(character: character)
    }
    
    private func setUpHomeScreenDetailView() {
        selectedLabel.text = homeScreenDetailViewModel.characterName
        descriptionTextField.text = homeScreenDetailViewModel.characterDescription
    }
}
