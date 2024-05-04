//
//  CoreDataComic+CoreDataClass.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/30.
//

import Foundation
import CoreData

@objc(CoreDataComic)
public class CoreDataComic: NSManagedObject, MarvelData {
    
    @NSManaged public var id: Int
    @NSManaged public var name: String
    @NSManaged public var overview: String
    @NSManaged public var thumbnail: String
    @NSManaged public var hasBeenfavourited: Bool
}
