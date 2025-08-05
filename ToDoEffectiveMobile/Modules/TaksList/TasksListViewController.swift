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
    private let tasksCountLabel = UILabel()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupToolbar()
        setupEmptyStateLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    // MARK: - Init & Deinit
    deinit {
        
    }
    
    // MARK: - Table View Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getTasksCount() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        if let todo = presenter?.getTaskModel(for: indexPath.row) {
            cell.configure(with: todo)
            cell.onCheckboxTappedHandler = { [weak self] in
                guard let self else { return }
                presenter?.onTaskCheckboxTapped(todo)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter?.onTaskTapped(index: indexPath.row)
    }
    
    override func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: { [weak self] in
            guard let self, let presenter, let task = presenter.getTaskModel(for: indexPath.row) else { return UIViewController() }
            let preview = TaskPreviewViewController(task: task)
            return preview
        }, actionProvider: { [weak self] _ in
            guard let self else { return nil }
            let editAction = UIAction(title: "Редактировать", image: UIImage(systemName: "square.and.pencil")) { _ in
                self.presenter?.onEditActionTapped(at: indexPath.row)
            }
            let shareAction = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                self.presenter?.onShareActionTapped(at: indexPath.row)
            }
            let deleteAction = UIAction(title: "Удалить", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                self.presenter?.onDeleteActionTapped(at: indexPath.row)
            }
            return UIMenu(title: "", children: [editAction, shareAction, deleteAction])
        })
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

        tasksCountLabel.text = "\(presenter?.getTasksCount() ?? 0) Задач"
        tasksCountLabel.font = .systemFont(ofSize: 13)
        tasksCountLabel.textAlignment = .center
        
        let labelContainer = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        tasksCountLabel.frame = labelContainer.bounds
        labelContainer.addSubview(tasksCountLabel)
        
        let centerItem = UIBarButtonItem(customView: labelContainer)
        
        self.toolbarItems = [
            UIBarButtonItem(systemItem: .flexibleSpace),
            centerItem,
            UIBarButtonItem(systemItem: .flexibleSpace),
            UIBarButtonItem(
                image: UIImage(systemName: "square.and.pencil"),
                style: .plain,
                target: self,
                action: #selector(createTapped)
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
    func createTapped() {
        presenter?.onCreateTaskDidTap()
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
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        present(alert, animated: true)
    }
    
    func showCreateTaskView() {
        let alert = UIAlertController(title: "Добавить новую заметку", message: nil, preferredStyle: .alert)
        alert.addTextField { titleTextField in
            titleTextField.placeholder = "Задача"
        }
        alert.addTextField { descriptionTextField in
            descriptionTextField.placeholder = "Описание - опционально"
        }
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            if let title = alert.textFields?[0].text, let description = alert.textFields?[1].text {
                presenter?.createTask(title: title, description: description)
            }
        }))
        present(alert, animated: true)
    }
    
    func addNewCellAnimated() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    func deleteCell(at indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    func updateTasksCountLabel(_ newCount: Int) {
        tasksCountLabel.text = "\(newCount) Задач"
    }
}
