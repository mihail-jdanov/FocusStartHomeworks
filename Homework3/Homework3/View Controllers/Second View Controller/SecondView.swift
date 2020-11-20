//
//  SecondView.swift
//  Homework3
//
//  Created by Михаил Жданов on 02.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class SecondView: UIView {
    
    private enum Constants {
        static let smallSpacing: CGFloat = 8
        static let standardSpacing: CGFloat = 16
        static let titleFontSize: CGFloat = 18
        static let titleNumberOfLines = 0
        static let textFontSize: CGFloat = 14
        static let textNumberOfLines = 0
    }
    
    // MARK: - Properties
    
    private lazy var compactConstraints: [NSLayoutConstraint] = [
        imageView.pin(.leading, to: .leading, of: scrollableContentView, constant: Constants.standardSpacing, activate: false),
        imageView.pin(.top, to: .top, of: scrollableContentView, constant: Constants.standardSpacing, activate: false),
        imageView.pin(.width, to: .width, of: scrollableContentView, multiplier: 0.3, activate: false),
        titleLabel.pin(.leading, to: .trailing, of: imageView, constant: Constants.standardSpacing, activate: false),
        titleLabel.pin(.top, to: .top, of: imageView, activate: false),
        titleLabel.pin(.bottom, to: .bottom, of: imageView, activate: false)
    ]
    
    private lazy var regularConstraints: [NSLayoutConstraint] = [
        imageView.pin(.leading, to: .leading, of: scrollableContentView, activate: false),
        imageView.pin(.top, to: .top, of: scrollableContentView, activate: false),
        imageView.pin(.trailing, to: .trailing, of: scrollableContentView, activate: false),
        titleLabel.pin(.leading, to: .leading, of: scrollableContentView, constant: Constants.standardSpacing, activate: false),
        titleLabel.pin(.top, to: .bottom, of: imageView, constant: Constants.standardSpacing, activate: false)
    ]
    
    private let image = Images.sunrise
    
    // MARK: - Views
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .always
        scrollView.indicatorStyle = .black
        return scrollView
    }()
    
    private let scrollableContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        label.textColor = .black
        label.numberOfLines = Constants.titleNumberOfLines
        label.textAlignment = .center
        label.text = "Lorem ipsum dolor sit amet"
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.textFontSize)
        label.textColor = .darkGray
        label.numberOfLines = Constants.textNumberOfLines
        label.textAlignment = .justified
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt "
            + "ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris "
            + "nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit "
            + "esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt "
            + "in culpa qui officia deserunt mollit anim id est laborum. "
        for _ in 0 ... 5 {
            var labelText = label.text ?? ""
            labelText += text
            label.text = labelText
        }
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        return imageView
    }()

    // MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureSubviews()
        refreshConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass ||
            traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass
        else { return }
        refreshConstraints()
    }

}

private extension SecondView {
    
    // MARK: - Views configuration
    
    func refreshConstraints() {
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.compact, .regular):
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
        default:
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
        }
    }
    
    func configureSubviews() {
        addSubviews()
        configureScrollView()
        configureScrollableContentView()
        configureImageView()
        titleLabel.pin(.trailing, to: .trailing, of: scrollableContentView, constant: -Constants.standardSpacing)
        configureTextlabel()
    }
    
    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(scrollableContentView)
        scrollableContentView.addSubview(imageView)
        scrollableContentView.addSubview(titleLabel)
        scrollableContentView.addSubview(textLabel)
    }
    
    func configureScrollView() {
        scrollView.pin(.leading, to: .leading, of: self)
        scrollView.pin(.trailing, to: .trailing, of: self)
        scrollView.pin(.top, to: .top, of: self)
        scrollView.pin(.bottom, to: .bottom, of: self)
    }
    
    func configureScrollableContentView() {
        scrollableContentView.pin(.leading, to: .leading, of: scrollView)
        scrollableContentView.pin(.trailing, to: .trailing, of: scrollView)
        scrollableContentView.pin(.top, to: .top, of: scrollView)
        scrollableContentView.pin(.bottom, to: .bottom, of: scrollView)
        scrollableContentView.pin(.width, to: .width, of: safeAreaLayoutGuide)
    }
    
    func configureImageView() {
        let aspectRatio = image.size.width / image.size.height
        imageView.pin(.width, to: .height, of: imageView, multiplier: aspectRatio)
    }
    
    func configureTextlabel() {
        textLabel.pin(.leading, to: .leading, of: scrollableContentView, constant: Constants.standardSpacing)
        textLabel.pin(.trailing, to: .trailing, of: scrollableContentView, constant: -Constants.standardSpacing)
        textLabel.pin(.top, to: .bottom, of: titleLabel, constant: Constants.standardSpacing)
        textLabel.pin(.bottom, to: .bottom, of: scrollableContentView, constant: -Constants.standardSpacing)
    }
    
}
