//
//  GameScreenCollectionViewCell.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/25.
//

//func generateRandomImages()  {
//    guard let correctGame = games.first(where: { $0.overview == currentGameDescription })?.thumbnail else { return }
//     
//    //let incorrectThumbnails = games.filter { $0.overview != currentGameDescription }.map { $0.thumbnail }
//    
//    let incorrectThumbnails = games.filter { $0.overview != currentGameDescription }
//                                   .map { "\($0.thumbnail)/portrait_incredible.jpg".convertToHttps() }
//    
//    
//    let randomIncorrectThumbnails = Array(incorrectThumbnails.shuffled().prefix(3))
//    testArrayTwo.append(correctGame)
//    testArrayTwo.append(contentsOf: randomIncorrectThumbnails)

import UIKit

class GameScreenCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var eventImageView: UIImageView!
    @IBOutlet weak private var cardView: UIView!
    
    // MARK: Variables
    
    // MARK: Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func gameNib() -> UINib {
        UINib(nibName: Constants.SegueIdentifierNames.gameScreenCollectionViewCellName, bundle: nil)
    }
    
    func setUpNib(gameImage: String) {
        eventImageView.load(urlString: gameImage)
        cardView.layer.borderWidth = 0
    }
    
    func correctAnswer() {
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.green.cgColor
    }
    
    func incorrectAnswer() {
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.red.cgColor
    }
}
