//
//  TasksListRouter.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 30.07.2025.
//  
//

import Foundation
import UIKit

final class TasksListRouter: PresenterToRouterTasksListProtocol {
    weak var vc: UIViewController?
    
    // MARK: - Assembly
    static func createModule() -> UIViewController {
        let presenter: ViewToPresenterTasksListProtocol & InteractorToPresenterTasksListProtocol = TasksListPresenter()
        let viewController = TasksListViewController()
        viewController.presenter = presenter
        let router = TasksListRouter()
        router.vc = viewController
        viewController.presenter?.router = router
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = TasksListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        return viewController
    }
    
    func navigateToTaskDetail(with task: TodoTaskModel) {
        let module = TaskDetailRouter.createModule()
        vc?.navigationController?.pushViewController(module, animated: true)
    }
}
