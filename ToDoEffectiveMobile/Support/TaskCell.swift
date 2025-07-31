//
//  TaskCell.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 30.07.2025.
//

import UIKit

final class TaskCell: UITableViewCell {
    static let identifier: String = "taks.cell.identifier.sjapi"
    
    // MARK: - Handler
    var onCheckboxTappedHandler: (() -> Void)? = nil
    
    // MARK: - UI
    private let checkboxButton = ExtendedTapAreaButton()
    
    private let containerStack = UIStackView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("nah, no storyboards")
    }
    
    func configure(with model: TodoTaskModel) {
        titleLabel.text = model.name
        subTitleLabel.text = model.description
        dateLabel.text = model.formattedTimestampCreated
        
        if model.isCompleted {
            titleLabel.textColor = .secondaryLabel
            titleLabel.setStrikeThrough(true)
            subTitleLabel.textColor = .secondaryLabel
            checkboxButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            checkboxButton.tintColor = .tintColor
        } else {
            titleLabel.textColor = .label
            titleLabel.setStrikeThrough(false)
            subTitleLabel.textColor = .label
            checkboxButton.setImage(UIImage(systemName: "circle"), for: .normal)
            checkboxButton.tintColor = .gray
        }
    }
}

// MARK: - Private Methods
private extension TaskCell {
    func configureAppearance() {
        containerStack.axis = .vertical
        containerStack.alignment = .leading
        containerStack.spacing = 6
        
        [titleLabel, subTitleLabel, dateLabel].forEach {
            $0.numberOfLines = 2
            containerStack.addArrangedSubview($0)
        }
        
        checkboxButton.extraTapArea = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        checkboxButton.addTarget(self, action: #selector(onCheckboxTapped), for: .touchUpInside)
        checkboxButton.contentVerticalAlignment = .fill
        checkboxButton.contentHorizontalAlignment = .fill
        checkboxButton.imageView?.contentMode = .scaleAspectFit
        
        [containerStack, checkboxButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            checkboxButton.widthAnchor.constraint(equalToConstant: 30),
            checkboxButton.heightAnchor.constraint(equalTo: checkboxButton.widthAnchor),
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkboxButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            containerStack.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 8),
            containerStack.topAnchor.constraint(equalTo: checkboxButton.topAnchor),
            containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    
    @objc func onCheckboxTapped() {
        print("checkbox tapped")
        onCheckboxTappedHandler?()
    }
}
