//
//  TasksListPresenter.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 30.07.2025.
//
//

import Foundation

final class TasksListPresenter: ViewToPresenterTasksListProtocol {
    // MARK: - VIPER Properties
    var view: PresenterToViewTasksListProtocol?
    var interactor: PresenterToInteractorTasksListProtocol?
    var router: PresenterToRouterTasksListProtocol?
    
    // MARK: - Other Properties
    private var tasks: [TodoTaskEntity] = []
    
    // MARK: - Init
    init() {
        
    }
    
    // MARK: - Public Methods
    func viewDidLoad() {
        interactor?.loadTasks()
    }
    
    func viewWillAppear() {
        interactor?.updateTasks()
    }
    
    func onTaskCheckboxTapped(_ model: TodoTaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == model.id }) {
            interactor?.changeTaskState(tasks[index])
        }
    }
    
    func onTaskTapped(index: Int) {
        router?.navigateToTaskDetail(with: tasks[index])
    }
    
    func searchTextDidChange(_ text: String) {
        interactor?.searchTextChanged(text)
    }
    
    func onEditActionTapped(at index: Int) {
    }
    
    func onShareActionTapped(at index: Int) {
    }
    
    func onDeleteActionTapped(at index: Int) {
        interactor?.deleteTask(tasks[index])
    }
    
    func getTasksCount() -> Int {
        return tasks.count
    }
    
    func getTaskModel(for index: Int) -> TodoTaskModel? {
        let entity = tasks[index]
        let task = TodoTaskModel(
            id: entity.id ?? UUID(),
            name: entity.title ?? "",
            description: entity.desc ?? "",
            timestampCreated: Int(entity.timestampCreated),
            timestampModified: Int(entity.timestampModified),
            isCompleted: entity.isCompleted
        )
        return task
    }
    
    func onCreateTaskDidTap() {
        view?.showCreateTaskView()
    }
    
    func createTask(title: String, description: String?) {
        interactor?.addNewTask(title: title, description: description)
    }
}

// MARK: - Private Methods
private extension TasksListPresenter {
}

// MARK: - InteractorToPresenterTasksListProtocol
extension TasksListPresenter: InteractorToPresenterTasksListProtocol {
    func tasksUpdated(_ result: Result<[TodoTaskEntity], Error>) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch result {
            case .success(let tasks):
                self.tasks = tasks
                view?.showEmptyStateLabel(tasks.count == 0)
                view?.updateTable()
                view?.updateTasksCountLabel(tasks.count)
            case .failure(let error):
                self.view?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    func taskStateChanged(_ task: TodoTaskEntity) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if let index = tasks.firstIndex(of: task) {
                view?.updateCell(at: IndexPath(row: index, section: 0))
            }
        }
    }
    
    func taskDeleted(_ task: TodoTaskEntity) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if let index = tasks.firstIndex(of: task) {
                tasks.remove(at: index)
                view?.deleteCell(at: IndexPath(row: index, section: 0))
//                view?.showEmptyStateLabel(tasks.isEmpty)
                view?.updateTasksCountLabel(tasks.count)
            }
        }
    }
    
    func newTaskAdded(_ task: TodoTaskEntity) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            tasks.insert(task, at: 0)
            view?.addNewCellAnimated()
            view?.updateTasksCountLabel(tasks.count)
        }
    }
}
