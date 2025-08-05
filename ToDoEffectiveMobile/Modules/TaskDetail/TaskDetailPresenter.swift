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
   
    // MARK: - Public Methods
    func viewDidLoad() {
        view?.setupUI()
        let title = interactor?.getTaskTitle() ?? ""
        let description = interactor?.getTaskDescription() ?? ""
        let timestamp = Formatter.formatTimestamp(interactor?.getTaskTimestamp() ?? 0)
        view?.updateInfo(title: title, description: description, timestamp: timestamp)
        view?.updateDescriptionPlaceholder(!description.isEmpty)
        view?.updateTitlePlaceholder(!title.isEmpty)
    }
    
    func viewWillAppear() {
        view?.hideTitleAndToolbar()
    }
    
    func viewWillDisappear() {
        view?.showTitleAndToolbar()
    }
    
    func touchesBegan() {
        view?.hideKeyboardIfNeeded()
    }
    
    func titleDidChange(_ new: String) {
        interactor?.updateTitle(new)
    }
    
    func descriptionDidChange(_ new: String) {
        interactor?.updateDescription(new)
    }
    
    func didPressTitleEnter() {
        view?.hideKeyboardIfNeeded()
    }
    
    func didPressDescriptionEnter() {
        view?.hideKeyboardIfNeeded()
    }
}

// MARK: - Private Methods
private extension TaskDetailPresenter {
    
}

// MARK: - InteractorToPresenterTaskDetailProtocol
extension TaskDetailPresenter: InteractorToPresenterTaskDetailProtocol {
    func taskUpdated(_ task: TodoTaskEntity) {
        let title = task.title ?? ""
        let description = task.desc ?? ""
        let timestamp = Formatter.formatTimestamp(Int(task.timestampCreated))
        view?.updateInfo(title: title, description: description, timestamp: timestamp)
        view?.updateDescriptionPlaceholder(!description.isEmpty)
        view?.updateTitlePlaceholder(!title.isEmpty)
    }
}
