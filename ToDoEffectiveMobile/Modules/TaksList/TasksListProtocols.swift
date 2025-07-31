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
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterTasksListProtocol: AnyObject {
    var view: PresenterToViewTasksListProtocol? { get set }
    var interactor: PresenterToInteractorTasksListProtocol? { get set }
    var router: PresenterToRouterTasksListProtocol? { get set }
    
    var tasksList: [TodoTaskModel] { get }
    func onTaskCheckboxTapped(index: Int)
    func onTaskTapped(index: Int)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTasksListProtocol {
    var presenter: InteractorToPresenterTasksListProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTasksListProtocol: AnyObject {
    
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterTasksListProtocol {
    
}
