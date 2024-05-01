//
//  CoreDataCharacter+CoreDataProperties.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/30.
//

import Foundation
import CoreData

extension CoreDataCharacter {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataCharacter> {
        return NSFetchRequest<CoreDataCharacter>(entityName: "CoreDataCharacter")
    }
}
