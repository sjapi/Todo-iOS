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
    private var allTasksList: [TodoTaskModel] = []
    var tasksList: [TodoTaskModel] = []

    var presenter: InteractorToPresenterTasksListProtocol?
    
    // MARK: - Public Methods
    func loadTasks() {
        print("loadTasks interactor method called")
        if UserDefaultsManager.shared.areTodosDownloaded {
            print("lets load from db")
            loadFromDB()
        } else {
            print("lets load from server")
            loadFromServer()
        }
    }
    
    func changeTaskState(id: Int) {
        self.tasksList[id].isCompleted.toggle()
        presenter?.taskStateChanged(id: id)
    }
    
    func searchTextChanged(_ text: String) {
        if text.isEmpty {
            tasksList = allTasksList
        } else {
            tasksList = allTasksList.filter {
                $0.name.lowercased().contains(text.lowercased()) ||
                $0.description?.lowercased().contains(text.lowercased()) ?? false
            }
        }
        presenter?.tasksUpdated(.success(tasksList))
    }
    
    func deleteTask(id: Int) {
        tasksList.remove(at: id)
        presenter?.tasksUpdated(.success(tasksList))
    }
    
    func addNewTask(title: String, description: String?) {
        let now = Int(Date.now.timeIntervalSince1970)
        let new = TodoTaskModel(name: title, description: description, timestampCreated: now, timestampModified: now, isCompleted: false)
        tasksList = [new] + tasksList
        presenter?.newTaskAdded(new)
    }
}

// MARK: - Private Methods
private extension TasksListInteractor {
    // MARK: Load Tasks
    func loadFromServer() {
        allTasksList = mock()
        tasksList = allTasksList
        
        guard InternetConnectionObserver.shared.isReachable else {
            presenter?.tasksUpdated(.failure(NetworkError.noConnection))
            return
        }
        networkManager.loadTodoTasks { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                saveResponseToDB(response)
                presenter?.tasksUpdated(.success(tasksList))
                // UserDefaultsManager.shared.areTodosDownloaded = true
            case .failure(let error):
                presenter?.tasksUpdated(.failure(error))
                print(error)
            }
        }
    }
    
    func loadFromDB() {
        presenter?.tasksUpdated(.success(tasksList))
    }

    // MARK: Other
    func saveResponseToDB(_ tasks: DummyJsonResponseModel) {
        
    }
    
    func mock() -> [TodoTaskModel] {
        return [
            .init(name: "Купить продукты", description: "Список: молоко, хлеб, яйца", timestampCreated: 1627812000, timestampModified: 1627815600, isCompleted: true),
            .init(name: "Позвонить маме", description: "Узнать, как дела", timestampCreated: 1627812600, timestampModified: 1627816200, isCompleted: true),
            .init(name: "Написать отчёт", description: "Финальный отчёт по проекту", timestampCreated: 1627813200, timestampModified: 1627816800, isCompleted: false),
            .init(name: "Сходить в спортзал", description: "Тренировка: ноги и спина", timestampCreated: 1627813800, timestampModified: 1627817400, isCompleted: true),
            .init(name: "Погулять с собакой", description: "Прогулка вечером", timestampCreated: 1627814400, timestampModified: 1627818000, isCompleted: true),
            .init(name: "Прочитать книгу", description: "Закончить последнюю главу", timestampCreated: 1627815000, timestampModified: 1627818600, isCompleted: false),
            .init(name: "Оплатить счета", description: "Коммуналка и интернет", timestampCreated: 1627815600, timestampModified: 1627819200, isCompleted: false),
            .init(name: "Убраться дома", description: "Пропылесосить и помыть пол", timestampCreated: 1627816200, timestampModified: 1627819800, isCompleted: true),
            .init(name: "Посмотреть фильм", description: "Выбрать новый фильм", timestampCreated: 1627816800, timestampModified: 1627820400, isCompleted: true),
            .init(name: "Составить план на завтра", description: "Записать задачи и встречи", timestampCreated: 1627817400, timestampModified: 1627821000, isCompleted: true)
        ]
    }
}
