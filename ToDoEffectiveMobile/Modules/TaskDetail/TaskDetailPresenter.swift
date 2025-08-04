//
//  TaskDetailPresenter.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 04.08.2025.
//  
//

import Foundation

final class TaskDetailPresenter: ViewToPresenterTaskDetailProtocol {
    // MARK: Properties
    var view: PresenterToViewTaskDetailProtocol?
    var interactor: PresenterToInteractorTaskDetailProtocol?
    var router: PresenterToRouterTaskDetailProtocol?
}

// MARK: - Private Methods
private extension TaskDetailPresenter {
    
}

// MARK: - InteractorToPresenterTaskDetailProtocol
extension TaskDetailPresenter: InteractorToPresenterTaskDetailProtocol {
    
}
