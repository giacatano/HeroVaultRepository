//
//  UserFavouritesViewModel.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation

class UserFavouritesViewModel: ViewModelDelegate {
    func reloadView() {
    }
    
    private var userFavouritesRepository: UserFavouritesScreenRepositoryType?
    private weak var delegate: ViewModelDelegate?
    
    init(userFavouritesRepository: UserFavouritesScreenRepositoryType, delegate: ViewModelDelegate) {
        self.userFavouritesRepository = userFavouritesRepository
        self.delegate = delegate
    }
}


// TODO: Do all table view stuff with delegates
