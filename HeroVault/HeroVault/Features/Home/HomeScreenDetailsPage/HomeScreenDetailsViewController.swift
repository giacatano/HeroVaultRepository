//
//  HomeScreenDetailsViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/18.
//

import UIKit

class HomeScreenDetailsViewController: UIViewController {
    
    private lazy var homeScreenDetailViewModel = HomeScreenDetailsViewModel()
    
    //MARK: IBOutlets
    @IBOutlet weak private var mainStackView: UIStackView!
    @IBOutlet weak private var userRatingLabel: UILabel!
    @IBOutlet weak private var ratingImage: UIImageView!
    @IBOutlet weak private var discoverLabel: UILabel!
    @IBOutlet weak private var selectedImage: UIImageView!
    @IBOutlet weak private var selectedLabel: UILabel!
    @IBOutlet weak private var descriptionTextField: UITextView!
    
    //MARK: IBActions
    
    @IBAction func starButton(_ sender: Any) {
        
    }
    
    //MARK: ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainStackView.layer.cornerRadius = 10
        print(homeScreenDetailViewModel.character ?? "empty")
    }
    
    func set(character: Characters) {
        homeScreenDetailViewModel.set(character: character)
    }
}
