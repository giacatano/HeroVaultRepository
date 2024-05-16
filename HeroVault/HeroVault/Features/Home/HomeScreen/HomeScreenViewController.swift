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
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    @IBOutlet weak private var noResultsLabel: UILabel!
    
    // MARK: Actions
    
    @IBAction private func segmentedControlTapped(_ sender: Any) {
        searchBar.text = ""
        let segmentedControlTitle = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) ?? ""
        homeScreenViewModel.handleSegmentedControl(segmentedControlTitle: segmentedControlTitle)
    }
    
    // MARK: Variables
    
    private lazy var homeScreenViewModel = HomeScreenViewModel(homeScreenRepository: HomeScreenRepository(), delegate: self, testDelegate: self)
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenViewModel.fetchMarvelData()
        setUpTableView()
        setUpSearchBar()
        noResultsLabel.isHidden = homeScreenViewModel.hideNoResultsText
    }
    
    private func setUpSearchBar() {
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .black
        searchBar.searchTextField.backgroundColor = .white
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
        homeScreenViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let homePageTableViewCell = listTableView.dequeueReusableCell(withIdentifier: Constants.SegueIdentifierNames.homeScreenTableViewCellName,
                                                                            for: indexPath) as? HomeScreenTableViewCell else {
            return UITableViewCell()
        }

        let (marvelName, marvelImage) = homeScreenViewModel.fetchMarvelNameAndImage(for: indexPath.section)
        homePageTableViewCell.setUpNib(marvelName: marvelName, marvelImage: marvelImage)
        return homePageTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.SegueIdentifierNames.homeScreenDetailSegueName, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        homeScreenViewModel.isLoading ? nil : indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath,
           segue.identifier == Constants.SegueIdentifierNames.homeScreenDetailSegueName {
            if let homeScreenDetailScreen = segue.destination as? HomeScreenDetailsViewController {
                if let marvelData = homeScreenViewModel.fetchMarvelData(atIndex: indexPath.section) {
                    homeScreenDetailScreen.set(marvelData: marvelData)
                }
            }
        }
    }
}

extension HomeScreenViewController: ViewModelProtocol {
    func reloadView() {
        listTableView.reloadData()
    }
}

extension HomeScreenViewController: TestProtocol {
    func startLoading() {
        homeScreenViewModel.isLoading = true
        view.showLoading()
        listTableView.isHidden = true
    }
    
    func stopLoading() {
        homeScreenViewModel.isLoading = false
        view.stopLoading()
        listTableView.isHidden = false
    }
}

extension HomeScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homeScreenViewModel.filterMarvelData(filteredText: searchText)
        noResultsLabel.isHidden = homeScreenViewModel.hideNoResultsText
    }
}
