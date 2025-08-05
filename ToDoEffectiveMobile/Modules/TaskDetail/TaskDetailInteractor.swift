//
//  TaskDetailInteractor.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 04.08.2025.
//  
//

import Foundation

final class TaskDetailInteractor: PresenterToInteractorTaskDetailProtocol {
    // MARK: Properties
    var presenter: InteractorToPresenterTaskDetailProtocol?
    private var task: TodoTaskModel

    // MARK: - Init
    init(task: TodoTaskModel) {
        self.task = task
    }
    
    // MARK: - Public Methods
    func getTaskTitle() -> String? {
        return task.name
    }
    
    func getTaskDescription() -> String? {
        return task.description
    }
    
    func getTaskTimestamp() -> Int? {
        return task.timestampCreated
    }
    
    func updateTitle(_ new: String) {
        task.name = new
        presenter?.taskUpdated(task)
    }
    
    func updateDescription(_ new: String) {
        task.description = new
        presenter?.taskUpdated(task)
    }
}

// MARK: - Private Methods
private extension TaskDetailInteractor {
    
}
