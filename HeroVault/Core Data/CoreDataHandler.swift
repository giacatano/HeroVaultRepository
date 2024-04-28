//
//  CoreDataHandler.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/28.
//

import CoreData
import UIKit

class CoreDataHandler {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Core Data Saving support
      func saveContext () {
          if context.hasChanges {
          do {
              try context.save()
          } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
        }
      }
    
    func getAllComics() -> [Comics]? {
        var characters: [Comics]? = []
        do {
            characters = try context.fetch(Comics.fetchRequest())
        } catch {
            
        }
        return characters
    }
    
    func getAllCharacters() -> [Characters]? {
        var characters: [Characters]? = []
        do {
            characters = try context.fetch(Characters.fetchRequest())
        } catch {
            
        }
        return characters
    }

}
