//
//  UserFavouritesScreenCollectionViewCell.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/29.
//

import UIKit

class UserFavouritesScreenCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var favouritedImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    
    // MARK: Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpNib()
    }
    
    static func characterNib() -> UINib {
        UINib(nibName: Constants.SegueIdentifierNames.userFavouritesScreenCollectionViewCellName, bundle: nil)
    }

    func setUpImage(with image: UIImage, name: String) {
        favouritedImageView.image = image
    }
    
    private func setUpNib() {
        backgroundColor = UIColor.white
        favouritedImageView.layer.cornerRadius = 10
        favouritedImageView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true

    }
}
