//
//  TasksListPresenter.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 30.07.2025.
//  
//

import Foundation

final class TasksListPresenter: ViewToPresenterTasksListProtocol {
    // MARK: Properties
    var view: PresenterToViewTasksListProtocol?
    var interactor: PresenterToInteractorTasksListProtocol?
    var router: PresenterToRouterTasksListProtocol?
}

extension TasksListPresenter: InteractorToPresenterTasksListProtocol {
    
}
