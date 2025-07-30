//
//  TasksListViewController.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 30.07.2025.
//
//

import UIKit

final class TasksListViewController: UITableViewController {
    // MARK: - Properties
    weak var presenter: ViewToPresenterTasksListProtocol?
    
    // MARK: - UI
    private let searchController = UISearchController()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupToolbar()
    }
    
    // MARK: - Table View Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        cell.configure(completed: Bool.random())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - Private Methods
private extension TasksListViewController {
    func setupNavigationBar() {
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupToolbar() {
        navigationController?.isToolbarHidden = false
        let centerLabel = UILabel()
        centerLabel.text = "10 Задач"
        centerLabel.font = .systemFont(ofSize: 13)
        centerLabel.sizeToFit()
        let centerItem = UIBarButtonItem(customView: centerLabel)
        self.toolbarItems = [
            UIBarButtonItem(systemItem: .flexibleSpace),
            centerItem,
            UIBarButtonItem(systemItem: .flexibleSpace),
            UIBarButtonItem(
                image: UIImage(systemName: "square.and.pencil"),
                style: .plain,
                target: self,
                action: #selector(editTapped)
            )
        ]
    }
    
    func setupTableView() {
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
    }
}

@objc private extension TasksListViewController {
    func editTapped() {
        print("edit")
    }
}

// MARK: - UISearchBarDelegate
extension TasksListViewController: UISearchBarDelegate {
    
}

// MARK: - PresenterToViewTasksListProtocol
extension TasksListViewController: PresenterToViewTasksListProtocol {
    
}
