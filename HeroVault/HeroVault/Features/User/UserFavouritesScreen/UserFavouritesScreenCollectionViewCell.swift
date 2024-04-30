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
    @IBOutlet weak var favouritedLabel: UILabel!
    
    
    // MARK: Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpNib()
    }
    
    static func characterNib() -> UINib {
        UINib(nibName: Constants.SegueIdentifierNames.userFavouritesScreenCollectionViewCellName, bundle: nil)
    }

    func setUpNib(with image: UIImage, name: String) {
        favouritedLabel.text = name
        favouritedImageView.image = image
    }
    
    private func setUpNib() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        backgroundColor = UIColor.clear
    }
}
