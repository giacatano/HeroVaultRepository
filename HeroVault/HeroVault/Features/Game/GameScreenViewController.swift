//
// GameScreenViewController.swift
// HeroVault
//
// Created by Gia Catano on 2024/04/03.
//

import UIKit

class GameScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var overviewLabel: UILabel!
    @IBOutlet weak private var instructionLabel: UILabel!
    @IBOutlet weak private var gameCollectionView: UICollectionView!
    @IBOutlet weak private var currentScoreLabel: UILabel!
    @IBOutlet weak private var playButtonLabel: UIButton!
    @IBOutlet weak private var highScoreLabel: UILabel!
    @IBOutlet weak var overviewContainer: UIView!
    
    // MARK: IBActions
    
    @IBAction func playButton(_ sender: Any) {
        gameScreenViewModel.playAgain()
        playButtonLabel.isHidden = true
        gameScreenViewModel.cellsClickable = true
    }
    
    // MARK: Variables
    
    private lazy var gameScreenViewModel = GameScreenViewModel(gameScreenRepository: GameScreenRepository(apiHandler: APIHandler(),
                                                                                                          coreDataHandler: CoreDataHandler()),
                                                               delegate: self)
    // MARK: Functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpCollectionView()
        setUpView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameScreenViewModel.fetchEvents()
    }
    
    private func setUpCollectionView() {
        gameCollectionView.register(GameScreenCollectionViewCell.gameNib(),
                                    forCellWithReuseIdentifier:
                                        Constants.SegueIdentifierNames.gameScreenCollectionViewCellName)
        gameCollectionView.dataSource = self
        gameCollectionView.delegate = self
    }
    
    private func setUpView() {
        gameScreenViewModel.cellsClickable = true
        playButtonLabel.isHidden = true
        overviewLabel.text = gameScreenViewModel.generateDescription
        gameScreenViewModel.indexOfCurrentGameThumbnails = 0
        gameScreenViewModel.generateImage()
        gameCollectionView.reloadData()
        currentScoreNumber()
        highScoreLabel.text = "Highest score: \(gameScreenViewModel.highScore)"
    }
    
    private func currentScoreNumber() {
        currentScoreLabel.text = "Current score: \(gameScreenViewModel.score)"
    }
}

// MARK: Extensions

extension GameScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currentCell = collectionView.cellForItem(at: indexPath) as? GameScreenCollectionViewCell else {
            return
        }
        guard gameScreenViewModel.cellsClickable else {
            return
        }
        gameScreenViewModel.checkAnswer(atIndex: indexPath.row) ? handleCorrectAnswer(for: currentCell) :
        handleIncorrectAnswer(for: currentCell, collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 170, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let gameScreenCollectionViewCell =
                gameCollectionView.dequeueReusableCell(withReuseIdentifier:
                                                        Constants.SegueIdentifierNames.gameScreenCollectionViewCellName,
                                                       for: indexPath) as? GameScreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        gameScreenCollectionViewCell.setUpNib(gameImage: gameScreenViewModel.populateCellImage)
        return gameScreenCollectionViewCell
    }
    
    private func handleCorrectAnswer(for cell: GameScreenCollectionViewCell) {
        cell.correctAnswer()
        reloadView()
        currentScoreNumber()
    }
    
    private func handleIncorrectAnswer(for cell: GameScreenCollectionViewCell, collectionView: UICollectionView) {
        cell.incorrectAnswer()
        gameScreenViewModel.cellsClickable = false
        gameScreenViewModel.newHighScore() ? showNewHighScore() : showError()
        gameScreenViewModel.resetScore()
        highlightCorrectCell(in: collectionView)
    }
    
    private func highlightCorrectCell(in collectionView: UICollectionView) {
        guard let correctIndex = gameScreenViewModel.correctIndex else {
            return
        }
        guard let correctCell = collectionView.cellForItem(at: IndexPath(row: correctIndex, section: 0)) as?
                GameScreenCollectionViewCell else {
            return
        }
        correctCell.correctAnswer()
    }
}

extension GameScreenViewController: ViewModelProtocol {
    func startLoadingIndicator() {
        view.showLoadingIndicator()
        gameCollectionView.isHidden = true
        currentScoreLabel.isHidden = true
        playButtonLabel.isHidden = true
        highScoreLabel.isHidden = true
        //overviewContainer.isHidden = true
        instructionLabel.isHidden = true
    }
    
    func stopLoadingIndicator() {
        view.stopLoadingIndicator()
        gameCollectionView.isHidden = false
        currentScoreLabel.isHidden = false
        highScoreLabel.isHidden = false
       // overviewContainer.isHidden = false
        instructionLabel.isHidden = false
    }
    
    func reloadView() {
        setUpView()
        setUpCollectionView()
        gameCollectionView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Game Over", message: "Your score was \(gameScreenViewModel.score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.playButtonLabel.isHidden = false
            self.gameScreenViewModel.cellsClickable = false
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNewHighScore() {
        let alert = UIAlertController(title:
                                        "New High Score",
                                      message: "Your score was \(gameScreenViewModel.score)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.playButtonLabel.isHidden = false
            self.gameScreenViewModel.cellsClickable = false
            self.highScoreLabel.text = self.gameScreenViewModel.highScore
        })
        self.present(alert, animated: true, completion: nil)
    }
}
