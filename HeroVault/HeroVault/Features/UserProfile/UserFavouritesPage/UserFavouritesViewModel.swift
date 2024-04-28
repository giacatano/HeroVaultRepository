//
//  UserFavouritesViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation

class UserFavouritesViewModel {
    
    // MARK: Variables
    private var test = CoreDataHandler()
    var characters = [Character]()
    var comics = [Comic]()
    var error: Error?
    
    private weak var delegate: ViewModelDelegate?
  
    
    init(delegate: ViewModelDelegate) {
        self.delegate = delegate
    }
    
    func showSavedComics() -> [Characters]? {
        return test.getAllCharacters()
    }
    
    func showSavedCharacters() -> [Characters]? {
        return test.getAllCharacters()
    }
    
    
}
