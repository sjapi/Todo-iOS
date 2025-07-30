//
//  TasksListViewController.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 30.07.2025.
//  
//

import UIKit

final class TasksListViewController: UIViewController {
    // MARK: - Properties
    weak var presenter: ViewToPresenterTasksListProtocol?

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Private Methods
private extension TasksListViewController {
    
}

// MARK: - PresenterToViewTasksListProtocol
extension TasksListViewController: PresenterToViewTasksListProtocol {
}
