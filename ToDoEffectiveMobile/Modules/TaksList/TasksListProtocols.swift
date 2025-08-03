//
//  TasksListContract.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 30.07.2025.
//  
//

import Foundation

// MARK: View Output (Presenter -> View)
protocol PresenterToViewTasksListProtocol {
    func updateCell(at indexPath: IndexPath)
    func updateTable()
    func showEmptyStateLabel(_ isShown: Bool)
    func showErrorAlert(message: String)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterTasksListProtocol: AnyObject {
    var view: PresenterToViewTasksListProtocol? { get set }
    var interactor: PresenterToInteractorTasksListProtocol? { get set }
    var router: PresenterToRouterTasksListProtocol? { get set }
    
    func viewDidLoad()
    func onTaskCheckboxTapped(index: Int)
    func onTaskTapped(index: Int)
    func searchTextDidChange(_ text: String)
    func onEditActionTapped(at index: Int)
    func onShareActionTapped(at index: Int)
    func onDeleteActionTapped(at index: Int)
    func getTasksCount() -> Int
    func getTaskModel(for index: Int) -> TodoTaskModel?
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTasksListProtocol {
    var presenter: InteractorToPresenterTasksListProtocol? { get set }
   
    var tasksList: [TodoTaskModel] { get }
    func loadTasks()
    func searchTextChanged(_ text: String)
    func changeTaskState(id: Int)
    func deleteTask(id: Int)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTasksListProtocol: AnyObject {
    func tasksUpdated(_ result: Result<[TodoTaskModel], Error>)
    func taskStateChanged(id: Int)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterTasksListProtocol {
    
}
