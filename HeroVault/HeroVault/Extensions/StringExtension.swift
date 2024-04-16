//
//  StringExtension.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/16.
//

import Foundation

extension String {
    func convertToHttps() -> String {
            var url = self
            let zerothIndex = url.startIndex
            let fourthIndex = url.index(zerothIndex, offsetBy: 4)
            if (url[zerothIndex...fourthIndex] == "http:") {
                url.insert("s", at: fourthIndex)
                return url
            } else {
                return url
            }
        }
}
