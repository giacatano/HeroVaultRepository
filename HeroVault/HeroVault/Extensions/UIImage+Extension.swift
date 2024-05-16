//
//  UIImage+Extension.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/05/15.
//

import UIKit

extension UIImage {
    
    static func gifImages(data: Data) -> [UIImage]? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        
        let count = CGImageSourceGetCount(source)
        var images = [UIImage]()
        for counter in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, counter, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
        }
        return images.isEmpty ? nil : images
    }
    
    static func gifDuration(data: Data) -> TimeInterval? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        
        let count = CGImageSourceGetCount(source)
        var duration: TimeInterval = 0
        for counter in 0..<count {
            if let properties = CGImageSourceCopyPropertiesAtIndex(source, counter, nil) as? [String: Any],
               let gifProperties = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any],
               let frameDuration = gifProperties[kCGImagePropertyGIFUnclampedDelayTime as String] as? NSNumber {
                duration += frameDuration.doubleValue
            }
        }
        return duration > 0 ? duration : nil
    }
}
