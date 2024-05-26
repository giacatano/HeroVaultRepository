//
//  GameScreenCollectionViewCell.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/25.
//

import UIKit

class GameScreenCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var eventImageView: UIImageView!
    @IBOutlet weak private var cardView: UIView!
    
    // MARK: Variables
    
//    override var isSelected: Bool {
//        didSet {
//            layer.borderColor = borderColor
//        }
//    }
//    
//    private var borderColor: CGColor {
//        return isSelected ? UIColor.red.cgColor : UIColor.green.cgColor
//    }
    
    // MARK: Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        correctAnswer()
        incorrectAnswer()
//        setUpUINib()
    }
    
    static func gameNib() -> UINib {
        UINib(nibName: Constants.SegueIdentifierNames.gameScreenCollectionViewCellName, bundle: nil)
    }
    
    func setUpNib(gameImage: String) {
        eventImageView.load(urlString: gameImage)
    }
    
//    func setUpUINib() {
//        layer.borderWidth = 1
//        layer.borderColor = borderColor
//    }
    
    func correctAnswer() {
        cardView.layer.borderColor = UIColor.green.cgColor
    }
    
    func incorrectAnswer() {
        cardView.layer.borderColor = UIColor.red.cgColor
    }
}
