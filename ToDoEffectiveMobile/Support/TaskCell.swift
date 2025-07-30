//
//  TaskCell.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 30.07.2025.
//

import UIKit

final class TaskCell: UITableViewCell {
    static let identifier: String = "taks.cell.identifier.sjapi"
    
    // MARK: - UI
    private let checkboxView = UIImageView()
    
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
    
    func configure(completed: Bool) {
        titleLabel.text = "Заняться спортом"
        subTitleLabel.text = "Сходить в спортзал или сделать тренировку дома. Не забыть про разминку и растяжку!"
        dateLabel.text = "09/02/24"
        if completed {
            titleLabel.textColor = .secondaryLabel
            titleLabel.setStrikeThrough(true)
            subTitleLabel.textColor = .secondaryLabel
            checkboxView.image = UIImage(systemName: "checkmark.circle")
            checkboxView.tintColor = .tintColor
        } else {
            titleLabel.textColor = .label
            titleLabel.setStrikeThrough(false)
            subTitleLabel.textColor = .label
            checkboxView.image = UIImage(systemName: "circle")
            checkboxView.tintColor = .gray
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
        [checkboxView, containerStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        NSLayoutConstraint.activate([
            checkboxView.widthAnchor.constraint(equalToConstant: 30),
            checkboxView.heightAnchor.constraint(equalTo: checkboxView.widthAnchor),
            checkboxView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            checkboxView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            
            containerStack.leadingAnchor.constraint(equalTo: checkboxView.trailingAnchor, constant: 8),
            containerStack.topAnchor.constraint(equalTo: checkboxView.topAnchor),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
}
