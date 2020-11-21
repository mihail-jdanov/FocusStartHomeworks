//
//  CoreDataService.swift
//  Homework5
//
//  Created by Михаил Жданов on 18.09.2020.
//

import Foundation
import CoreData

final class CoreDataService {
    
    // MARK: - Properties
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Homework5")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
        return container
    }()
    
    // MARK: - Methods

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchObjects<T: NSManagedObject>(ofType type: T.Type) -> [T]? {
        let request = NSFetchRequest<T>(entityName: T.className)
        var objects: [T]?
        do {
            objects = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        return objects
    }
    
}
