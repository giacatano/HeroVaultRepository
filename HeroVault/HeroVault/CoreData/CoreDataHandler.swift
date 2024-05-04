//
//  CoreDataHandler.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/30.
//

import CoreData
import UIKit

// MARK: - Entity Type Enum

enum EntityType: String {
case character
case comic

    var rawValue: String {
        switch self {
        case .character:
            return Constants.CoreData.characterEntityName
        case .comic:
            return Constants.CoreData.comicEntityName
        }
    }
}

// MARK: - Core Data Handler Protocol

protocol CoreDataHandlerType {
    func fetchAllObjectsFromCoreData(entityType: EntityType) -> [MarvelData]?
    func saveObjectIntoCoreData(_ object: MarvelData)
    func deleteObjectFromCoreData(_ object: MarvelData)
    func deleteAllObjectsFromCoreData()
    //delete this one
    func showAllNames() -> [String]
}

// MARK: - Core Data Class

class CoreDataHandler: CoreDataHandlerType {
    
    let appDelegate: AppDelegate
    let context: NSManagedObjectContext
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access AppDelegate")
        }
        
        self.appDelegate = appDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Core Data CRUD functions
    
    func fetchAllObjectsFromCoreData(entityType: EntityType) -> [MarvelData]? {
        if entityType == .character {
            do {
                return try context.fetch(CoreDataCharacter.fetchRequest())
            } catch {
                return nil
            }
        } else {
            do {
                return try context.fetch(CoreDataComic.fetchRequest())
            } catch {
                return nil
            }
        }
    }
    
    func saveObjectIntoCoreData(_ object: MarvelData) {
        let entityType: EntityType = object is Character ? .character : .comic
        if !doesObjectExistInCoreData(object, entityType: entityType) {
            createObjectInCoreData(object)
            saveContext()
            print("saved into core data: \(object.name)")
        } else {
            print("already in list: \(object.name)")
        }
    }
    
    func deleteObjectFromCoreData(_ object: MarvelData) {
        
        var objectToBeDeleted: MarvelData?
        
        if object is Character {
            if let characterObject = fetchCharacterByID(object.id) {
                objectToBeDeleted = characterObject
            }
        } else {
            if let comicObject = fetchComicByID(object.id) {
                objectToBeDeleted = comicObject
            }
        }
        
        if let objectToBeDeleted {
            deleteObject(objectToBeDeleted)
            print("deleted from core data: \(object.name)")
        }
    }
    
    func deleteAllObjectsFromCoreData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CoreDataCharacter.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? context.execute(batchDeleteRequest)
    }
    
    // Can be deleted later
    func showAllNames() -> [String] {
        
        var characters: [CoreDataCharacter]? = []
        var names: [String] = []
        
        do {
            characters = try context.fetch(CoreDataCharacter.fetchRequest())
        } catch {
        }
        for number in 0..<((characters?.count ?? -1)) {
            names.append(characters?[number].name ?? "no name")
        }
        print("here are the names: \(names)")
        return names
    }
    
    // MARK: - Core Data Helper Functions
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func createObjectInCoreData(_ object: MarvelData) {
        if object is Character {
            let newCharacter = CoreDataCharacter(context: context)
            newCharacter.name = object.name
            newCharacter.id = object.id
            newCharacter.overview = object.overview
            newCharacter.thumbnail = object.thumbnail
        } else {
            let newComic = CoreDataComic(context: context)
            newComic.name = object.name
            newComic.id = object.id
            newComic.overview = object.overview
            newComic.thumbnail = object.thumbnail
        }
    }
    
    private func deleteObject(_ object: MarvelData) {
        if let managedObject = object as? NSManagedObject {
            context.delete(managedObject)
            saveContext()
        }
    }
    
    private func fetchComicByID(_ id: Int) -> MarvelData? {
        
        let fetchRequest: NSFetchRequest<CoreDataComic> = CoreDataComic.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Error fetching character: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func fetchCharacterByID(_ id: Int) -> MarvelData? {
        
        let fetchRequest: NSFetchRequest<CoreDataCharacter> = CoreDataCharacter.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Error fetching character: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func doesObjectExistInCoreData(_ object: MarvelData, entityType: EntityType) -> Bool {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityType.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id == %d", object.id)
        
        do {
            let count = try context.count(for: fetchRequest)
            if count > 0 {
                print("Number of objects with character ID \(object.id): \(count)")
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
}
