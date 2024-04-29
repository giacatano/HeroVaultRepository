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
        UINib(nibName: Constants.SegueIdentifierNames.homeScreenTableViewCellName, bundle: nil)
    }

    func setUpNib(imageName: String, imageURL: String ) {
        favouritedLabel.text = imageName
        favouritedImageView.load(urlString: imageURL)
    }
    
    private func setUpNib() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        backgroundColor = UIColor.clear
    }
}
