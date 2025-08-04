//
//  TasksListContract.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 30.07.2025.
//  
//

import Foundation
import UIKit.UIViewController

// MARK: View Output (Presenter -> View)
protocol PresenterToViewTasksListProtocol {
    func updateCell(at indexPath: IndexPath)
    func updateTable()
    func addNewCellAnimated()
    func showEmptyStateLabel(_ isShown: Bool)
    func showErrorAlert(message: String)
    func showCreateTaskView()
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterTasksListProtocol: AnyObject {
    var view: PresenterToViewTasksListProtocol? { get set }
    var interactor: PresenterToInteractorTasksListProtocol? { get set }
    var router: PresenterToRouterTasksListProtocol? { get set }
    
    func viewDidLoad()
    func onTaskCheckboxTapped(index: Int)
    func onTaskTapped(index: Int)
    func onCreateTaskDidTap()
    func searchTextDidChange(_ text: String)
    func onEditActionTapped(at index: Int)
    func onShareActionTapped(at index: Int)
    func onDeleteActionTapped(at index: Int)
    func getTasksCount() -> Int
    func getTaskModel(for index: Int) -> TodoTaskModel?
    func createTask(title: String, description: String?)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTasksListProtocol {
    var presenter: InteractorToPresenterTasksListProtocol? { get set }
   
    var tasksList: [TodoTaskModel] { get }
    func loadTasks()
    func searchTextChanged(_ text: String)
    func changeTaskState(id: Int)
    func deleteTask(id: Int)
    func addNewTask(title: String, description: String?)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTasksListProtocol: AnyObject {
    func tasksUpdated(_ result: Result<[TodoTaskModel], Error>)
    func taskStateChanged(id: Int)
    func newTaskAdded(_ task: TodoTaskModel)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterTasksListProtocol {
    func navigateToTaskDetail(with task: TodoTaskModel)
}
