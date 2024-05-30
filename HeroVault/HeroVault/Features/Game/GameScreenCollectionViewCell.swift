//
// GameScreenCollectionViewCell.swift
// HeroVault
//
// Created by Gia Catano on 2024/05/25.
//

import UIKit

class GameScreenCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var eventImageView: UIImageView!
    @IBOutlet weak private var cardView: UIView!
    
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
        cardView.layer.borderWidth = 3
        cardView.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    func incorrectAnswer() {
        cardView.layer.borderWidth = 3
        cardView.layer.borderColor = UIColor.red.cgColor
    }
}
