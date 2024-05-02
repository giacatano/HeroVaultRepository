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
    @IBOutlet weak private var discoverLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Actions
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    // MARK: Variables
    
    private lazy var homeScreenViewModel = HomeScreenViewModel(homeScreenRepository: HomeScreenRepository(), delegate: self)
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenViewModel.fetchCharacters()
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
        homeScreenViewModel.characterCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let homePageTableViewCell = listTableView.dequeueReusableCell(withIdentifier: Constants.SegueIdentifierNames.homeScreenTableViewCellName,
                                                                            for: indexPath) as? HomeScreenTableViewCell else {
            return UITableViewCell()
        }
        
        let imageName = homeScreenViewModel.characters[indexPath.section].name
        let imageURL = homeScreenViewModel.createImage(characterIndex: indexPath.section)
        
        homePageTableViewCell.setUpNib(imageName: imageName, imageURL: imageURL)
        return homePageTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.SegueIdentifierNames.homeScreenDetailSegueName, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath,
           segue.identifier == Constants.SegueIdentifierNames.homeScreenDetailSegueName {
            if let homeScreenDetailScreen = segue.destination as? HomeScreenDetailsViewController {
                if let characters = homeScreenViewModel.fetchCharacters(atIndex: indexPath.section) {
                    homeScreenDetailScreen.set(character: characters)
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
