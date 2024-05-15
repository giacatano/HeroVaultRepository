//
//  HomeScreenTableViewCell.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/12.
//

import UIKit

class HomeScreenTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var characterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUINib()
    }
    
    // MARK: Functions
    
    static func characterNib() -> UINib {
        UINib(nibName: Constants.SegueIdentifierNames.homeScreenTableViewCellName, bundle: nil)
    }
    
    func setUpNib(marvelName: String, marvelImage: String) {
        nameLabel.text = marvelName
        characterImageView.load(urlString: marvelImage)
    }
    
    private func setUpUINib() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        backgroundColor = UIColor.clear
    }
}
