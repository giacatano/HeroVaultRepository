//
//  HomeScreenTableViewCell.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/12.
//

import UIKit

class HomeScreenTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var characterImageView: UIImageView!
    @IBOutlet weak private var starImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpNib()
    }
    
    //MARK: HomeScreenTableViewCell Functions
    
    static func characterNib() -> UINib {
        UINib(nibName: Constants.SegueIdentifierNames.homeScreenTableViewCellName, bundle: nil)
    }
    
    func setUpNib(imageName: String, imageURL: String ) {
        nameLabel.text = imageName
        characterImageView.load(urlString: imageURL)
    }
    
    private func setUpNib() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        backgroundColor = UIColor.clear
    }
}
