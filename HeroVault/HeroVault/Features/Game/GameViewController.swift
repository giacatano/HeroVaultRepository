//
//  EventsViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/03.
//

import UIKit

class GameViewController: UIViewController {
    
    private var gameViewModel = GameViewModel(gameRespository: GameRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //gameViewModel.fetchEvents()
    }
}
