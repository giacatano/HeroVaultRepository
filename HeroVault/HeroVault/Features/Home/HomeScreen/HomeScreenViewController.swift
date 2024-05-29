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
        noResultsLabel.isHidden = true
        segmentedControl.isHidden = false
        searchBar.isHidden = false
    }
    
    // MARK: Variables
    
    private lazy var homeScreenViewModel = HomeScreenViewModel(homeScreenRepository: HomeScreenRepository(), delegate: self)
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenViewModel.fetchMarvelData()
        setUpTableView()
        setUpSearchBar()
        setUpSegmentedControl()
        noResultsLabel.isHidden = homeScreenViewModel.hideNoResultsText
    }
    
    private func setUpSearchBar() {
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .primaryText
        searchBar.searchTextField.backgroundColor = .primaryCard
        hideKeyboardWhenTappedAround()
        searchBar.searchTextField.clearButtonMode = .never
    }
    
    private func setUpTableView() {
        listTableView.register(HomeScreenTableViewCell.characterNib(),
                               forCellReuseIdentifier: Constants.SegueIdentifierNames.homeScreenTableViewCellName)
        listTableView.dataSource = self
        listTableView.delegate = self
    }
    
    private func setUpSegmentedControl() {
        var selectedSegmentAttributes: [NSAttributedString.Key: Any] = [:]
        segmentedControl.backgroundColor = .primaryCard
        segmentedControl.tintColor = .primary
        selectedSegmentAttributes[.foregroundColor] = UIColor.white
        segmentedControl.setTitleTextAttributes(selectedSegmentAttributes, for: .selected)
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
        homePageTableViewCell.selectionStyle = .none
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
                if let marvelData = homeScreenViewModel.fetchMarvelData(atIndex: indexPath.section) {
                    homeScreenDetailScreen.set(marvelData: marvelData)
                }
            }
        }
    }
}

extension HomeScreenViewController: ViewModelProtocol {
    func startLoadingIndicator() {
        view.showLoadingIndicator()
        listTableView.isHidden = true
        segmentedControl.isHidden = true
        searchBar.isHidden = true
    }
    
    func stopLoadingIndicator() {
        view.stopLoadingIndicator()
        listTableView.isHidden = false
        segmentedControl.isHidden = false
        searchBar.isHidden = false
    }
    
    func reloadView() {
        listTableView.reloadData()
    }
}

extension HomeScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homeScreenViewModel.filterMarvelData(filteredText: searchText)
        noResultsLabel.isHidden = homeScreenViewModel.hideNoResultsText
    }
}
