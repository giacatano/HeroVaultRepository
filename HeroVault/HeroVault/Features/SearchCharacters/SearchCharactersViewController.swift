//
//  ViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/03/27.
//

import UIKit

class CharacterNamesViewController: UIViewController {
    
    private var characterNamesViewModel = CharacterNamesViewModel(characterRepository: CharacterRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterNamesViewModel.fetchCharacters()
    }
}
