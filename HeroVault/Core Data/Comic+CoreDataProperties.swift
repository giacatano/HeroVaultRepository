////
////  Comic+CoreDataProperties.swift
////  HeroVault
////
////  Created by Gia Catano on 2024/04/28.
////
//
import Foundation
import CoreData

extension Comics {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comics> {
        return NSFetchRequest<Comics>(entityName: "Comics")
    }
    
//    @NSManaged public var id: Int?
}
