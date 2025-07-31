//
//  TaskPreviewViewController.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 01.08.2025.
//

import UIKit

final class TaskPreviewViewController: UIViewController {
    private let task: TodoTaskModel
   
    // MARK: - UI Elements
    private let containerStack = UIStackView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Init
    init(task: TodoTaskModel) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .popover
    }
    
    required init?(coder: NSCoder) {
        fatalError("all my homies do ui without storyboard")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        updatePreferredContentSize()
    }
}

// MARK: - Private Methods
private extension TaskPreviewViewController {
    func configureAppearance() {
        titleLabel.text = task.name
        subTitleLabel.text = task.description ?? ""
        dateLabel.text = task.formattedTimestampCreated
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        containerStack.axis = .vertical
        containerStack.alignment = .leading
        containerStack.spacing = 6
        
        [titleLabel, subTitleLabel, dateLabel].forEach {
            containerStack.addArrangedSubview($0)
        }
        
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerStack)
        
        NSLayoutConstraint.activate([
            containerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            containerStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
    private func updatePreferredContentSize() {
        view.layoutIfNeeded()
        let screenWidth = UIScreen.main.bounds.width
        let horizontalPadding: CGFloat = 32
        let targetWidth = screenWidth - horizontalPadding
        let targetSize = CGSize(width: targetWidth, height: UIView.layoutFittingCompressedSize.height)
        let size = view.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        preferredContentSize = CGSize(width: targetWidth, height: size.height)
    }
}
