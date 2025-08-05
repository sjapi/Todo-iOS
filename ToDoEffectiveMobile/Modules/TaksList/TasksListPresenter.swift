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
    
    // MARK: - Init
    init() {
        
    }
    
    // MARK: - Public Methods
    func viewDidLoad() {
        interactor?.loadTasks()
    }
    
    func onTaskCheckboxTapped(index: Int) {
        interactor?.changeTaskState(id: index)
    }
    
    func onTaskTapped(index: Int) {
        guard let task = interactor?.tasksList[index] else { return }
        router?.navigateToTaskDetail(with: task)
    }
    
    func searchTextDidChange(_ text: String) {
        interactor?.searchTextChanged(text)
    }
    
    func onEditActionTapped(at index: Int) {
        print("edit")
    }
    
    func onShareActionTapped(at index: Int) {
        print("share")
    }
    
    func onDeleteActionTapped(at index: Int) {
        interactor?.deleteTask(id: index)
    }
    
    func getTasksCount() -> Int {
        return interactor?.tasksList.count ?? 0
    }
    
    func getTaskModel(for index: Int) -> TodoTaskModel? {
        return interactor?.tasksList[index]
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
    func tasksUpdated(_ result: Result<[TodoTaskModel], Error>) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch result {
            case .success(_):
                view?.showEmptyStateLabel(interactor?.tasksList.count ?? 1 == 0)
                view?.updateTable()
            case .failure(let error):
                self.view?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    func taskStateChanged(id: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            view?.updateCell(at: IndexPath(row: id, section: 0))
        }
    }
    
    func newTaskAdded(_ task: TodoTaskModel) {
        view?.addNewCellAnimated()
    }
}
