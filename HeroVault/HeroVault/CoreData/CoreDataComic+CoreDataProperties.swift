//
//  CoreDataComic+CoreDataProperties.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/30.
//

import Foundation
import CoreData

extension CoreDataComic {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataComic> {
        return NSFetchRequest<CoreDataComic>(entityName: "CoreDataComic")
    }
}
