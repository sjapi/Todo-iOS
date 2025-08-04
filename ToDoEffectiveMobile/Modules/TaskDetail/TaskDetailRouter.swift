//
//  TaskDetailRouter.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 04.08.2025.
//  
//

import Foundation
import UIKit

final class TaskDetailRouter: PresenterToRouterTaskDetailProtocol {
    // MARK: Static methods
    static func createModule() -> UIViewController {
        let viewController = TaskDetailViewController()
        let presenter: ViewToPresenterTaskDetailProtocol & InteractorToPresenterTaskDetailProtocol = TaskDetailPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = TaskDetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = TaskDetailInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        return viewController
    }
    
}
