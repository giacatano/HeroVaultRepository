//
//  GameScreenViewController.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/03.
//

import UIKit

class GameScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var eventOverviewLabel: UILabel!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    
    // MARK: Variables
    
    private lazy var gameScreenViewModel = GameScreenViewModel(gameScreenRepository: GameScreenRepository(apiHandler: APIHandler(), coreDataHandler: CoreDataHandler()), delegate: self)
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameScreenViewModel.fetchEvents()
        setUpCollectionView()
        setUpEvent()
    }
    
    func setUpEvent() {
        eventOverviewLabel.text = gameScreenViewModel.generateDescription()
    }
    
    private func setUpCollectionView() {
        gameCollectionView.register(GameScreenCollectionViewCell.gameNib(),
                                    forCellWithReuseIdentifier:
                                        Constants.SegueIdentifierNames.gameScreenCollectionViewCellName)
        gameCollectionView.dataSource = self
        gameCollectionView.delegate = self
    }
}

//Collectionview stuff must live

// MARK: Extensions

extension GameScreenViewController: ViewModelProtocol {
    func startLoadingIndicator() {
        //view.showLoadingIndicator()
        //listTableView.isHidden = true
    }
    
    func stopLoadingIndicator() {
        // view.stopLoadingIndicator()
        // listTableView.isHidden = false
    }
    
    func reloadView() {
        //listTableView.reloadData()
        //label.text = gameViewModel.generateDescription()
    }
}

extension GameScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected me")
        //        if let = collectionView.cellForItem(at: indexPath) as? GameScreenCollectionViewCell {
        //            GameScreenCollectionViewCell.correctAnswer(<#T##self: GameScreenCollectionViewCell##GameScreenCollectionViewCell#>)
        //        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 140, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let gameScreenCollectionViewCell =
                gameCollectionView.dequeueReusableCell(withReuseIdentifier:
                                                        Constants.SegueIdentifierNames.gameScreenCollectionViewCellName,
                                                       for: indexPath) as? GameScreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        gameScreenCollectionViewCell.setUpNib(gameImage: gameScreenViewModel.generateImage())
        return gameScreenCollectionViewCell
    }
}

