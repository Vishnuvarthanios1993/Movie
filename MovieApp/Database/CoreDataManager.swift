//
//  CoreDataManager.swift
//  MovieTask
//
//  Created by Vishnuvarthan on 26/2/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "MovieApp")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data error: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func save() {
        do {
            try context.save()
        } catch {
            print("Failed to save Core Data: \(error)")
        }
    }
}

