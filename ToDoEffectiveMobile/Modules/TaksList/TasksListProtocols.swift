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
protocol PresenterToViewTasksListProtocol: AnyObject {
    func setupUI()
    func updateTable()
    func updateCell(at indexPath: IndexPath)
    func deleteCell(at indexPath: IndexPath)
    func addNewCellAnimated()
    func updateTasksCountLabel(_ newCount: Int)
    
    func showEmptyStateLabel(_ isShown: Bool)
    func showErrorAlert(message: String)
    func showCreateTaskView()
    func showShareSheet(text: String)
    func showLoader(_ isShown: Bool)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterTasksListProtocol: AnyObject {
    var view: PresenterToViewTasksListProtocol? { get set }
    var interactor: PresenterToInteractorTasksListProtocol? { get set }
    var router: PresenterToRouterTasksListProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func onTaskCheckboxTapped(_ model: TodoTaskModel)
    func onTaskTapped(index: Int)
    func onCreateTaskDidTap()
    func searchTextDidChange(_ text: String)
    func onEditActionTapped(_ task: TodoTaskModel)
    func onShareActionTapped(_ task: TodoTaskModel)
    func onDeleteActionTapped(_ task: TodoTaskModel)
    func getTasksCount() -> Int
    func getTaskModel(for index: Int) -> TodoTaskModel?
    func createTask(title: String, description: String?)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTasksListProtocol {
    var presenter: InteractorToPresenterTasksListProtocol? { get set }
   
    func loadTasks()
    func searchTextChanged(_ text: String)
    func changeTaskState(_ task: TodoTaskEntity)
    func deleteTask(_ task: TodoTaskEntity)
    func addNewTask(title: String, description: String?)
    func updateTasks()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTasksListProtocol: AnyObject {
    func tasksUpdated(_ result: Result<[TodoTaskEntity], Error>)
    func taskStateChanged(_ task: TodoTaskEntity)
    func taskDeleted(_ task: TodoTaskEntity)
    func newTaskAdded(_ task: TodoTaskEntity)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterTasksListProtocol {
    func navigateToTaskDetail(with task: TodoTaskEntity, edit: Bool)
}
