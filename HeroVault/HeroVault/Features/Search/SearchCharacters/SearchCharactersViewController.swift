//
//  ViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/03/27.
//

import UIKit

class CharacterNamesViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var discoverLabel: UILabel!
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return characterNamesViewModel.characterCount
       }

    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("you did select me")
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let result = characterNamesViewModel.(atIndex: indexPath.section) else { return }
         performSegue(withIdentifier: "detailScreenSegue", sender: result)
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier, for: indexPath) as? CharactersTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = String(characterNamesViewModel.characters[indexPath.section].name)
        var imageURL = characterNamesViewModel.createImage(characterIndex: indexPath.section)
        cell.characterImageView.load(urlString: imageURL)
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 4
      }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView = UIView()
         headerView.backgroundColor = UIColor.clear
         return headerView
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370.0
    }
}

extension CharacterNamesViewController: ViewModelDelegate {
    func reloadView() {
        self.listTableView.reloadData()
    }
}
