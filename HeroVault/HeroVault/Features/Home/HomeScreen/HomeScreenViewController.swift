//
//  HomeScreenViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/03/27.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: Actions
    
    @IBAction private func segmentedControlTapped(_ sender: Any) {
        let segmentedControlTitle = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        segmentedControlTitle == "Characters" ? homeScreenViewModel.set(marvelDataType: EntityType.character) : 
        homeScreenViewModel.set(marvelDataType: EntityType.comic)
        homeScreenViewModel.fetchMarvelData()
    }
    
    // MARK: Variables
    
    private lazy var homeScreenViewModel = HomeScreenViewModel(homeScreenRepository: HomeScreenRepository(), delegate: self)
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenViewModel.fetchMarvelData()
        setUpTableView()
    }
    
    private func setUpTableView() {
        listTableView.register(HomeScreenTableViewCell.characterNib(),
                               forCellReuseIdentifier: Constants.SegueIdentifierNames.homeScreenTableViewCellName)
        listTableView.dataSource = self
        listTableView.delegate = self
    }
}

// MARK: Extensions

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        homeScreenViewModel.marvelDataCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let homePageTableViewCell = listTableView.dequeueReusableCell(withIdentifier: Constants.SegueIdentifierNames.homeScreenTableViewCellName,
                                                                            for: indexPath) as? HomeScreenTableViewCell else {
            return UITableViewCell()
        }
        
        let imageName = homeScreenViewModel.marvelData[indexPath.section].name
        let imageURL = homeScreenViewModel.createImage(marvelIndex: indexPath.section)
        
        homePageTableViewCell.setUpNib(imageName: imageName, imageURL: imageURL)
        return homePageTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.SegueIdentifierNames.homeScreenDetailSegueName, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath,
           segue.identifier == Constants.SegueIdentifierNames.homeScreenDetailSegueName {
            if let homeScreenDetailScreen = segue.destination as? HomeScreenDetailsViewController {
                if let characters = homeScreenViewModel.fetchCharacters(atIndex: indexPath.section) {
                    homeScreenDetailScreen.set(marvelData: characters)
                }
            }
        }
    }
}

extension HomeScreenViewController: ViewModelDelegate {
    func reloadView() {
        listTableView.reloadData()
    }
}
