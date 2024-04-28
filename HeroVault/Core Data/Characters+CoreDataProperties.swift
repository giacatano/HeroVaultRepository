//
//  Characters+CoreDataProperties.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import Foundation
import CoreData

extension Characters {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Characters> {
        return NSFetchRequest<Characters>(entityName: "Characters")
    }
    
//    @NSManaged public var id: Int?
}
