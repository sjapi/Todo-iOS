//
//  TaskDetailContract.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 04.08.2025.
//  
//

import Foundation

// MARK: - View Output (Presenter -> View)
protocol PresenterToViewTaskDetailProtocol {
   
}

// MARK: - View Input (View -> Presenter)
protocol ViewToPresenterTaskDetailProtocol {
    var view: PresenterToViewTaskDetailProtocol? { get set }
    var interactor: PresenterToInteractorTaskDetailProtocol? { get set }
    var router: PresenterToRouterTaskDetailProtocol? { get set }
}


// MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTaskDetailProtocol {
    var presenter: InteractorToPresenterTaskDetailProtocol? { get set }
}


// MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTaskDetailProtocol {
    
}


// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterTaskDetailProtocol {
    
}
