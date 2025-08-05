//
//  CoreDataManager.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 05.08.2025.
//

import Foundation
import CoreData

final class CoreDataManager {
    // MARK: - Singleton
    static let shared = CoreDataManager()

    // MARK: - CoreData Attrs
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Init
    private init() {
        persistentContainer = NSPersistentContainer(name: "ToDoEffectiveMobile")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("CoreData: unable to load storage: \(error), \(error.userInfo)")
            }
        }
    }

    // MARK: - Public Methods
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("CoreData: context save error: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
