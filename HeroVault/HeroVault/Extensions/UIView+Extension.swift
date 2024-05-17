//
//  UIView+Extension.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/15.
//

import UIKit

extension UIView {
    
    static let loadingViewTag = 1
    
    func showLoadingIndicator() {
        var loadingImageView = viewWithTag(UIView.loadingViewTag) as? UIImageView
        
        if loadingImageView == nil {
            loadingImageView = UIImageView()
            loadingImageView?.translatesAutoresizingMaskIntoConstraints = false
            loadingImageView?.contentMode = .scaleAspectFit
            loadingImageView?.tag = UIView.loadingViewTag
            
            if let gifURL = Bundle.main.url(forResource: "Hero", withExtension: "gif"),
               let gifData = try? Data(contentsOf: gifURL),
               let images = UIImage.gifImages(data: gifData),
               let duration = UIImage.gifDuration(data: gifData) {
                loadingImageView?.animationImages = images
                loadingImageView?.animationDuration = duration
                loadingImageView?.startAnimating()
            }
            
            if let loadingImageView {
                addSubview(loadingImageView)
                NSLayoutConstraint.activate([
                    loadingImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                    loadingImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
                    loadingImageView.widthAnchor.constraint(equalToConstant: 100),
                    loadingImageView.heightAnchor.constraint(equalToConstant: 150)
                ])
            }
        }
    }
    
    func stopLoadingIndicator() {
        if let loading = viewWithTag(UIView.loadingViewTag) as? UIImageView {
            loading.stopAnimating()
            loading.removeFromSuperview()
        }
    }
}
