//
//  TasksListInteractor.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 30.07.2025.
//
//

import Foundation

final class TasksListInteractor: PresenterToInteractorTasksListProtocol {
    // MARK: Properties
    private let networkManager: NetworkManager = URLSessionNetworkManager()
    private var allTasksList: [TodoTaskEntity] = []
    
    weak var presenter: InteractorToPresenterTasksListProtocol?
    
    // MARK: - Public Methods
    func loadTasks() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            if UserDefaultsManager.shared.areTodosDownloaded {
                loadFromDB()
            } else {
                loadFromServer()
            }
        }
    }
    
    func updateTasks() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            loadFromDB()
        }
    }
    
    func changeTaskState(_ task: TodoTaskEntity) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            CoreDataManager.shared.toggleTaskState(task: task)
            presenter?.taskStateChanged(task)
        }
    }
    
    func searchTextChanged(_ text: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            let filtered = text.isEmpty
            ? allTasksList
            : allTasksList.filter {
                ($0.title?.localizedCaseInsensitiveContains(text) ?? false) ||
                ($0.desc?.localizedCaseInsensitiveContains(text) ?? false)
            }
            presenter?.tasksUpdated(.success(filtered))
        }
    }
    
    func deleteTask(_ task: TodoTaskEntity) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            CoreDataManager.shared.deleteTask(task: task)
            allTasksList = CoreDataManager.shared.getAllTasks()
            presenter?.taskDeleted(task)
        }
    }
    
    func addNewTask(title: String, description: String?) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            let now = Int64(Date.now.timeIntervalSince1970)
            let new = TodoTaskEntity(context: CoreDataManager.shared.context)
            new.id = UUID()
            new.title = title
            new.desc = description
            new.timestampCreated = now
            new.timestampModified = now
            new.isCompleted = false
            CoreDataManager.shared.saveTask(new: new)
            allTasksList = CoreDataManager.shared.getAllTasks()
            presenter?.newTaskAdded(new)
        }
    }
}

// MARK: - Private Methods
private extension TasksListInteractor {
    // MARK: Load Tasks
    func loadFromServer() {
        guard InternetConnectionObserver.shared.isReachable else {
            presenter?.tasksUpdated(.failure(NetworkError.noConnection))
            return
        }
        networkManager.loadTodoTasks { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                saveResponseToDB(response)
                presenter?.tasksUpdated(.success(allTasksList))
            case .failure(let error):
                presenter?.tasksUpdated(.failure(error))
            }
        }
    }
    
    func loadFromDB() {
        allTasksList = CoreDataManager.shared.getAllTasks()
        presenter?.tasksUpdated(.success(allTasksList))
    }
    
    func saveResponseToDB(_ tasks: DummyJsonResponseModel) {
        CoreDataManager.shared.saveTasksFromResponse(tasks)
        UserDefaultsManager.shared.areTodosDownloaded = true
        allTasksList = CoreDataManager.shared.getAllTasks()
    }
}
