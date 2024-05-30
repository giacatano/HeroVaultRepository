//
//  UIImageViewExtension.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/16.
//

import UIKit

extension UIImageView {
    func load(urlString: String) {
        if let safeURL = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: safeURL) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
