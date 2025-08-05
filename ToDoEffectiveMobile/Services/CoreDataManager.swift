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
        persistentContainer = NSPersistentContainer(name: "TodoTaskEntity")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("CoreData: unable to load storage: \(error), \(error.userInfo)")
            }
        }
    }
    
    // MARK: - Todo Methods
    func saveTasksFromResponse(_ response: DummyJsonResponseModel) {
        for task in response.todos {
            let entity = TodoTaskEntity(context: context)
            entity.id = UUID()
            entity.title = task.todo
            entity.desc = "Задача загружена из dummyjsom.com/todos"
            entity.isCompleted = task.completed
            entity.timestampCreated = Int64(Date().timeIntervalSince1970)
            entity.timestampModified = entity.timestampCreated
        }
        saveContext()
    }
    
    func getAllTasks() -> [TodoTaskEntity] {
        let request: NSFetchRequest<TodoTaskEntity> = TodoTaskEntity.fetchRequest()
        
        do {
            return try context.fetch(request).sorted(by: { $0.timestampCreated > $1.timestampCreated })
        } catch {
            return []
        }
    }
    
    func saveTask(new task: TodoTaskEntity) {
        saveContext()
    }
    
    func updateTaskTitle(task: TodoTaskEntity, newTitle: String) {
        task.title = newTitle
        task.timestampModified = Int64(Date().timeIntervalSince1970)
        saveContext()
    }
    
    func updateTaskDescription(task: TodoTaskEntity, newDescription: String) {
        task.desc = newDescription
        task.timestampModified = Int64(Date().timeIntervalSince1970)
        saveContext()
    }
    
    func toggleTaskState(task: TodoTaskEntity) {
        task.isCompleted.toggle()
        task.timestampModified = Int64(Date().timeIntervalSince1970)
        saveContext()
    }
    
    func deleteTask(task: TodoTaskEntity) {
        context.delete(task)
        saveContext()
    }
}

// MARK: - Private Methods
private extension CoreDataManager {
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
