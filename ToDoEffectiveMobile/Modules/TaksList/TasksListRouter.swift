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
    // MARK: - Assembly
    static func createModule() -> UIViewController {
        let presenter: ViewToPresenterTasksListProtocol & InteractorToPresenterTasksListProtocol = TasksListPresenter()
        let viewController = TasksListViewController()
        viewController.presenter = presenter
        viewController.presenter?.router = TasksListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = TasksListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        return viewController
    }
}
