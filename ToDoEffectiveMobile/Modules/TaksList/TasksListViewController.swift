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
    var presenter: ViewToPresenterTasksListProtocol?
    
    // MARK: - UI
    private let searchController = UISearchController()
    private let emptyStateLabel = UILabel()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupToolbar()
        setupEmptyStateLabel()
    }
    
    // MARK: - Init & Deinit
    deinit {
        
    }
    
    // MARK: - Table View Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tasksList.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        if let todo = presenter?.tasksList[indexPath.row] {
            cell.configure(with: todo)
            cell.onCheckboxTappedHandler = { [weak self] in
                guard let self else { return }
                presenter?.onTaskCheckboxTapped(index: indexPath.row)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter?.onTaskTapped(index: indexPath.row)
    }
}

// MARK: - Private Methods
private extension TasksListViewController {
    func setupNavigationBar() {
        title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupToolbar() {
        navigationController?.isToolbarHidden = false
        let centerLabel = UILabel()
        centerLabel.text = "\(presenter?.tasksList.count ?? 0) Задач"
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
    
    func setupEmptyStateLabel() {
        emptyStateLabel.text = "Нет задач"
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .secondaryLabel
        emptyStateLabel.isHidden = true
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateLabel)
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

// MARK: - Actions
@objc private extension TasksListViewController {
    func editTapped() {
        print("edit")
    }
}

// MARK: - UISearchBarDelegate
extension TasksListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchTextDidChange(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchTextDidChange("")
    }
}

// MARK: - UISearchControllerDelegate
extension TasksListViewController: UISearchControllerDelegate {
    func willDismissSearchController(_ searchController: UISearchController) {
        presenter?.searchTextDidChange("")
    }
}

// MARK: - Presenter -> View
extension TasksListViewController: PresenterToViewTasksListProtocol {
    func updateCell(at indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func updateTable() {
        tableView.reloadData()
    }
    
    func showEmptyStateLabel(_ isShown: Bool) {
        tableView.isUserInteractionEnabled = !isShown
        emptyStateLabel.isHidden = !isShown
    }
}
