//
//  MenuTableViewCell.swift
//  Homework4
//
//  Created by Михаил Жданов on 04.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var descriptionLabelTrailingToCellConstraint: NSLayoutConstraint = {
        return descriptionLabel.pin(
            .trailing,
            to: .trailing,
            of: safeAreaLayoutGuide,
            constant: -Spacings.standard,
            activate: false
        )
    }()
    
    private lazy var titleLabelBottomToCellConstraint: NSLayoutConstraint = {
        return titleLabel.pin(
            .bottom,
            to: .bottom,
            of: safeAreaLayoutGuide,
            constant: -Spacings.standard,
            activate: false
        )
    }()
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(withTitle title: String, description: String?, timeText: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
        timeLabel.text = timeText
        fixSpacingsIfNeeded()
    }
    
}

private extension MenuTableViewCell {
    
    // MARK: - Layout
    
    func layoutViews() {
        layoutTitleLabel()
        layoutDescriptionLabel()
        layoutTimeLabel()
    }
    
    func layoutTitleLabel() {
        addSubview(titleLabel)
        titleLabel.pin(.leading, to: .leading, of: safeAreaLayoutGuide, constant: Spacings.standard)
        titleLabel.pin(.trailing, to: .trailing, of: safeAreaLayoutGuide, constant: -Spacings.standard)
        titleLabel.pin(.top, to: .top, of: safeAreaLayoutGuide, constant: Spacings.standard)
    }
    
    func layoutDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.pin(.leading, to: .leading, of: titleLabel)
        descriptionLabel.pin(.top, to: .bottom, of: titleLabel, constant: Spacings.small)
        descriptionLabel.pin(.bottom, to: .bottom, of: safeAreaLayoutGuide, constant: -Spacings.standard)
            .priority = .preRequired
        descriptionLabel.setContentHuggingPriority(.lowest, for: .vertical)
    }
    
    func layoutTimeLabel() {
        addSubview(timeLabel)
        timeLabel.pin(.leading, to: .trailing, of: descriptionLabel, constant: Spacings.standard)
            .priority = .preRequired
        timeLabel.pin(.trailing, to: .trailing, of: titleLabel)
        timeLabel.pin(.top, to: .top, of: descriptionLabel, relation: .greaterThanOrEqual)
        timeLabel.pin(.bottom, to: .bottom, of: descriptionLabel)
        timeLabel.setContentHuggingPriority(.required, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    func fixSpacingsIfNeeded() {
        descriptionLabelTrailingToCellConstraint.isActive = timeLabel.text?.isEmpty != false
        titleLabelBottomToCellConstraint.isActive = timeLabel.text?.isEmpty != false
            && descriptionLabel.text?.isEmpty != false
    }
    
}
