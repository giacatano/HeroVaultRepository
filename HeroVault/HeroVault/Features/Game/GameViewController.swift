//
//  EventsViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/03.
//

import UIKit

class GameViewController: UIViewController {
    
    private var gameViewModel = GameViewModel(gameRepository: GameRepository(apiHandler: APIHandler(), coreDataHandler: CoreDataHandler()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameViewModel.fetchEvents()
    }
}
