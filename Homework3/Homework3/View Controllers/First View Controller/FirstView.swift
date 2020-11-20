//
//  FirstView.swift
//  Homework3
//
//  Created by Михаил Жданов on 02.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class FirstView: UIView {
    
    private enum Constants {
        static let smallSpacing: CGFloat = 8
        static let standardSpacing: CGFloat = 16
        static let largeFontSize: CGFloat = 30
        static let thirdLabelNumberOfLines = 2
        static let firstButtonWidth: CGFloat = 100
        static let secondButtonWidth: CGFloat = 200
        static let secondButtonHeight: CGFloat = 36
        static let secondButtonCornerRadius: CGFloat = 8
        static let imageViewAlpha: CGFloat = 0.4
    }
    
    // MARK: - Views
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "text1"
        label.textAlignment = .center
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "text2"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.largeFontSize)
        return label
    }()
    
    private let thirdLabel: UILabel = {
        let label = UILabel()
        label.text = "text3\ntext3"
        label.textAlignment = .center
        label.numberOfLines = Constants.thirdLabelNumberOfLines
        label.font = UIFont.systemFont(ofSize: Constants.largeFontSize, weight: .bold)
        return label
    }()
    
    private let firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("First button", for: .normal)
        return button
    }()
    
    private let secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.setTitle("Second button", for: .normal)
        button.layer.cornerRadius = Constants.secondButtonCornerRadius
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = Constants.imageViewAlpha
        imageView.contentMode = .scaleAspectFit
        imageView.image = Images.leo
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .lightGray
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension FirstView {
    
    // MARK: - Views configuration
    
    func configureSubviews() {
        addSubviews()
        configureStackView()
        configureFirstButton()
        configureSecondButton()
        configureActivityIndicator()
    }
    
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(thirdLabel)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.addArrangedSubview(imageView)
        imageView.addSubview(activityIndicator)
    }
    
    func configureStackView() {
        stackView.pin(.leading, to: .leading, of: safeAreaLayoutGuide, constant: Constants.standardSpacing)
        stackView.pin(.trailing, to: .trailing, of: safeAreaLayoutGuide, constant: -Constants.standardSpacing)
        stackView.pin(.top, to: .top, of: safeAreaLayoutGuide, constant: Constants.smallSpacing)
        stackView.pin(.bottom, to: .bottom, of: safeAreaLayoutGuide, constant: -Constants.smallSpacing)
    }
    
    func configureFirstButton() {
        firstButton.layer.cornerRadius = Constants.firstButtonWidth / 2
        firstButton.pin(.width, constant: Constants.firstButtonWidth)
        firstButton.pin(.height, to: .width, of: firstButton)
    }
    
    func configureSecondButton() {
        secondButton.pin(.width, constant: Constants.secondButtonWidth)
        secondButton.pin(.height, constant: Constants.secondButtonHeight)
    }
    
    func configureActivityIndicator() {
        activityIndicator.pin(.centerX, to: .centerX, of: imageView)
        activityIndicator.pin(.centerY, to: .centerY, of: imageView)
    }
    
}

