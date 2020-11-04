//
//  MenuTableViewCell.swift
//  Homework4
//
//  Created by Михаил Жданов on 04.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    // MARK: Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Test"
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
    
}

private extension MenuTableViewCell {
    
    // MARK: - Layout
    
    func layoutViews() {
        layoutTitleLabel()
    }
    
    func layoutTitleLabel() {
        addSubview(titleLabel)
        titleLabel.pin(.leading, to: .leading, of: safeAreaLayoutGuide, constant: Spacings.standard)
        titleLabel.pin(.trailing, to: .trailing, of: safeAreaLayoutGuide, constant: -Spacings.standard)
        titleLabel.pin(.top, to: .top, of: safeAreaLayoutGuide, constant: Spacings.standard)
        titleLabel.pin(.bottom, to: .bottom, of: safeAreaLayoutGuide, constant: -Spacings.standard)
    }
    
}
