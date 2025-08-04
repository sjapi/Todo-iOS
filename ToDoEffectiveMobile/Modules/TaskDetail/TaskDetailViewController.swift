//
//  TaskDetailViewController.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 04.08.2025.
//  
//

import UIKit

final class TaskDetailViewController: UIViewController {
    // MARK: - Properties
    var presenter: ViewToPresenterTaskDetailProtocol?
 
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
   
}

// MARK: - Private Extension
private extension TaskDetailViewController {
    func configureAppearance() {
        view.backgroundColor = .systemRed
    }
}

// MARK: - PresenterToViewTaskDetailProtocol
extension TaskDetailViewController: PresenterToViewTaskDetailProtocol{
}
