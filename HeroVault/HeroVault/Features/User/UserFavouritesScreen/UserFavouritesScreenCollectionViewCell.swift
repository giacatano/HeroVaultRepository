//
//  UserFavouritesScreenCollectionViewCell.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/29.
//

import UIKit

class UserFavouritesScreenCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak private var favouritedImageView: UIImageView!
    
    // MARK: Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func characterNib() -> UINib {
        UINib(nibName: Constants.SegueIdentifierNames.userFavouritesScreenCollectionViewCellName, bundle: nil)
    }
    
    func setUpNib(imageURL: String) {
        favouritedImageView.load(urlString: imageURL)
    }
}
