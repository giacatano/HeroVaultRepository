////
////  Comic+CoreDataClass.swift
////  HeroVault
////
////  Created by Gia Catano on 2024/04/28.
////
//
import Foundation
import CoreData

@objc(Comics)
public class Comics: NSManagedObject, Test {
    
//    init() {
//
//    }
    
    @NSManaged public var id: Int
    @NSManaged public var name: String
    @NSManaged public var overview: String
}
