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
    func updateInfo(title: String, description: String, timestamp: String)
    func setupUI()
    func hideKeyboardIfNeeded()
    
    func hideTitleAndToolbar()
    func showTitleAndToolbar()
    
    func updateTitlePlaceholder(_ isHidden: Bool)
    func updateDescriptionPlaceholder(_ isHidden: Bool)
}

// MARK: - View Input (View -> Presenter)
protocol ViewToPresenterTaskDetailProtocol {
    var view: PresenterToViewTaskDetailProtocol? { get set }
    var interactor: PresenterToInteractorTaskDetailProtocol? { get set }
    var router: PresenterToRouterTaskDetailProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func touchesBegan()
    func titleDidChange(_ new: String)
    func descriptionDidChange(_ new: String)
    func didPressTitleEnter()
    func didPressDescriptionEnter()
}


// MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTaskDetailProtocol {
    var presenter: InteractorToPresenterTaskDetailProtocol? { get set }
    
    func getTaskTitle() -> String?
    func getTaskDescription() -> String?
    func getTaskTimestamp() -> Int?
    
    func updateTitle(_ new: String)
    func updateDescription(_ new: String)
}


// MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTaskDetailProtocol {
    func taskUpdated(_ task: TodoTaskModel)
}


// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterTaskDetailProtocol {
    
}
