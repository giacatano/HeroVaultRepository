//
//  CharactersTableViewCell.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/12.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var starImageView: UIImageView!
    
    static let identifier = "CharactersTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
    }
    
    static func characterNib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}


