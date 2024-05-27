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
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpEvent()
        setUpCollectionView()
        gameCollectionView.reloadData()
        gameScreenViewModel.testArray = []
        gameScreenViewModel.testArrayThree = []
        gameScreenViewModel.counter = 0
        
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        gameScreenViewModel.fetchEvents()
        setUpCollectionView()
       // setUpEvent()
    }
    
    func setUpEvent() {
        eventOverviewLabel.text = gameScreenViewModel.generateDescription
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

extension GameScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected me")
        print(indexPath.row)
        
        if let test = collectionView.cellForItem(at: indexPath) as? GameScreenCollectionViewCell {
            if gameScreenViewModel.checkAnswer(atIndex: indexPath.row) {
                print(indexPath.row)
                test.correctAnswer()
            } else {
                test.incorrectAnswer()
            }
            
        }
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
        gameScreenCollectionViewCell.setUpNib(gameImage: gameScreenViewModel.generateImage)
        return gameScreenCollectionViewCell
    }
}


extension GameScreenViewController: ViewModelProtocol {
    func startLoadingIndicator() {
        view.showLoadingIndicator()
        gameCollectionView.isHidden = true
    }
    
    func stopLoadingIndicator() {
         view.stopLoadingIndicator()
        gameCollectionView.isHidden = false
    }
    
    func reloadView() {
        gameCollectionView.reloadData()
        eventOverviewLabel.text = gameScreenViewModel.generateDescription
    }
}

