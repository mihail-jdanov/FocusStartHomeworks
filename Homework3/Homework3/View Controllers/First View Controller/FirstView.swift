//
//  FirstView.swift
//  Homework3
//
//  Created by Михаил Жданов on 02.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class FirstView: UIView {
    
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
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private let thirdLabel: UILabel = {
        let label = UILabel()
        label.text = "text3\ntext3"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
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
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.4
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
        super.init(frame: frame)
        backgroundColor = .lightGray
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension FirstView {
    
    // MARK: - Layout
    
    func layoutViews() {
        layoutStackView()
        layoutFirstLabel()
        layoutSecondLabel()
        layoutThirdLabel()
        layoutFirstButton()
        layoutSecondButton()
        layoutImageView()
        layoutActivityIndicator()
    }
    
    func layoutStackView() {
        addSubview(stackView)
        stackView.pin(.leading, to: .leading, of: safeAreaLayoutGuide, constant: Spacings.standard)
        stackView.pin(.trailing, to: .trailing, of: safeAreaLayoutGuide, constant: -Spacings.standard)
        stackView.pin(.top, to: .top, of: safeAreaLayoutGuide, constant: Spacings.small)
        stackView.pin(.bottom, to: .bottom, of: safeAreaLayoutGuide, constant: -Spacings.small)
    }
    
    func layoutFirstLabel() {
        stackView.addArrangedSubview(firstLabel)
    }

    func layoutSecondLabel() {
        stackView.addArrangedSubview(secondLabel)
    }

    func layoutThirdLabel() {
        stackView.addArrangedSubview(thirdLabel)
    }
    
    func layoutFirstButton() {
        stackView.addArrangedSubview(firstButton)
        let width: CGFloat = 100
        firstButton.layer.cornerRadius = width / 2
        firstButton.pin(.width, constant: width)
        firstButton.pin(.height, to: .width, of: firstButton)
    }
    
    func layoutSecondButton() {
        stackView.addArrangedSubview(secondButton)
        secondButton.pin(.width, constant: 200)
        secondButton.pin(.height, constant: 36)
    }
    
    func layoutImageView() {
        stackView.addArrangedSubview(imageView)
    }
    
    func layoutActivityIndicator() {
        stackView.addSubview(activityIndicator)
        activityIndicator.pin(.centerX, to: .centerX, of: imageView)
        activityIndicator.pin(.centerY, to: .centerY, of: imageView)
    }
    
}

