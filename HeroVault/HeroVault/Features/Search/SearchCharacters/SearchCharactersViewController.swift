//
//  ViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/03/27.
//

import UIKit

class CharacterNamesViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    private lazy var characterNamesViewModel = CharacterNamesViewModel(characterRepository: CharacterRepository(), delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterNamesViewModel.fetchCharacters()
        setUpTableView()
    }
    
    private func setUpTableView() {
        listTableView.register(CharactersTableViewCell.characterNib(), forCellReuseIdentifier: CharactersTableViewCell.identifier)
        listTableView.dataSource = self
        listTableView.delegate = self
    }
}

extension CharacterNamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you did select me")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterNamesViewModel.characterCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier, for: indexPath) as? CharactersTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = String(characterNamesViewModel.characters[indexPath.row].name)
        return cell
    }
}

extension CharacterNamesViewController: ViewModelDelegate {
    func reloadView() {
        self.listTableView.reloadData()
    }
}
