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
    
    // MARK: - UI
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let titleTextView = UITextView()
    private let titlePlaceholderLabel = UILabel()
    
    private let dateLabel = UILabel()
    
    private let descriptionTextView = UITextView()
    private let descriptionPlaceholderLabel = UILabel()
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        presenter?.touchesBegan()
    }
}

// MARK: - Private Extension
private extension TaskDetailViewController {
    func configureAppearance() {
        view.backgroundColor = .systemBackground
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            //            containerView.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
    
    func setupTitle() {
        titleTextView.font = .preferredFont(forTextStyle: .extraLargeTitle)
        titleTextView.isScrollEnabled = false
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        titleTextView.backgroundColor = .clear
        titleTextView.delegate = self
        containerView.addSubview(titleTextView)
        
        titlePlaceholderLabel.text = "Задача"
        titlePlaceholderLabel.textColor = .secondaryLabel
        titlePlaceholderLabel.font = titleTextView.font
        titlePlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titlePlaceholderLabel)
        
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            titleTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            titlePlaceholderLabel.topAnchor.constraint(equalTo: titleTextView.topAnchor, constant: 8),
            titlePlaceholderLabel.leadingAnchor.constraint(equalTo: titleTextView.leadingAnchor, constant: 5),
            titlePlaceholderLabel.trailingAnchor.constraint(equalTo: titleTextView.trailingAnchor)
        ])
        
        titlePlaceholderLabel.isHidden = !titleTextView.text.isEmpty
    }
    
    
    func setupDate() {
        dateLabel.textColor = .secondaryLabel
        dateLabel.font = .preferredFont(forTextStyle: .subheadline)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTextView.backgroundColor = .clear
        containerView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    func setupDescription() {
        descriptionTextView.font = .preferredFont(forTextStyle: .body)
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.delegate = self
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(descriptionTextView)
        
        descriptionPlaceholderLabel.text = "Описание"
        descriptionPlaceholderLabel.font = descriptionTextView.font
        descriptionPlaceholderLabel.textColor = .secondaryLabel
        descriptionPlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(descriptionPlaceholderLabel)
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            descriptionPlaceholderLabel.topAnchor.constraint(equalTo: descriptionTextView.topAnchor, constant: 8),
            descriptionPlaceholderLabel.leadingAnchor.constraint(equalTo: descriptionTextView.leadingAnchor, constant: 5),
            descriptionPlaceholderLabel.trailingAnchor.constraint(equalTo: descriptionTextView.trailingAnchor)
        ])
        
        descriptionPlaceholderLabel.isHidden = !descriptionTextView.text.isEmpty
    }
    
}

// MARK: - UITextViewDelegate
extension TaskDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView === titleTextView {
            presenter?.titleDidChange(textView.text)
        } else if textView == descriptionTextView {
            presenter?.descriptionDidChange(textView.text)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            if textView === titleTextView {
                presenter?.didPressTitleEnter()
            } else if textView == descriptionTextView {
                presenter?.didPressDescriptionEnter()
            }
        }
        return true
    }
}

// MARK: - PresenterToViewTaskDetailProtocol
extension TaskDetailViewController: PresenterToViewTaskDetailProtocol{
    func updateInfo(title: String, description: String, timestamp: String) {
        titleTextView.text = title
        descriptionTextView.text = description
        dateLabel.text = timestamp
    }
    
    func setupUI() {
        configureAppearance()
        setupScrollView()
        setupTitle()
        setupDate()
        setupDescription()
    }
    
    func hideKeyboardIfNeeded() {
        if titleTextView.isFirstResponder {
            titleTextView.resignFirstResponder()
        } else if descriptionTextView.isFirstResponder {
            descriptionTextView.resignFirstResponder()
        }
    }
    
    func hideTitleAndToolbar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setToolbarHidden(true, animated: false)
        
    }
    
    func showTitleAndToolbar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    func updateTitlePlaceholder(_ isHidden: Bool) {
        titlePlaceholderLabel.isHidden = isHidden
    }
    
    func updateDescriptionPlaceholder(_ isHidden: Bool) {
        descriptionPlaceholderLabel.isHidden = isHidden
    }
}
