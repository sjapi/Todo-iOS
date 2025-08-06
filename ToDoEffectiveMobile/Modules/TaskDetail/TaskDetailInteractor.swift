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
    weak var presenter: InteractorToPresenterTaskDetailProtocol?
    private var task: TodoTaskEntity

    // MARK: - Init
    init(task: TodoTaskEntity) {
        self.task = task
    }
    
    // MARK: - Public Methods
    func getTaskTitle() -> String? {
        return task.title
    }
    
    func getTaskDescription() -> String? {
        return task.desc
    }
    
    func getTaskTimestamp() -> Int? {
        return Int(task.timestampCreated)
    }
    
    func updateTitle(_ new: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            CoreDataManager.shared.updateTaskTitle(task: task, newTitle: new)
            presenter?.taskUpdated(task)
        }
    }
    
    func updateDescription(_ new: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            CoreDataManager.shared.updateTaskDescription(task: task, newDescription: new)
            presenter?.taskUpdated(task)
        }
    }
    
    deinit {
        print("interactor deinit")
    }
}

// MARK: - Private Methods
private extension TaskDetailInteractor {
    
}
