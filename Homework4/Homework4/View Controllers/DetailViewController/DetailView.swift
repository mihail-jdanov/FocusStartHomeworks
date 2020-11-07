//
//  DetailView.swift
//  Homework4
//
//  Created by Михаил Жданов on 07.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    // MARK: - Views
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .always
        return scrollView
    }()
    
    private let scrollableContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var firstImageView: AspectFitCustomImageView = {
        let customImageView = AspectFitCustomImageView()
        customImageView.cornerRadius = 12
        customImageView.shadow = ShadowSettings(radius: 8, opacity: 0.5)
        return customImageView
    }()
    
    private lazy var secondImageView: AspectFitCustomImageView = {
        let customImageView = AspectFitCustomImageView()
        customImageView.cornerRadius = 12
        customImageView.shadow = ShadowSettings(radius: 8, opacity: 0.5)
        return customImageView
    }()
    
    // MARK: - Life сycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(withDescription description: String, firstImage: UIImage?, secondImage: UIImage?) {
        descriptionLabel.text = description
        firstImageView.image = firstImage
        secondImageView.image = secondImage
        scrollView.contentOffset = CGPoint(x: 0, y: -scrollView.safeAreaInsets.top)
    }
    
}

private extension DetailView {
    
    // MARK: - Layout
    
    func layoutViews() {
        layoutScrollView()
        layoutScrollableContentView()
        layoutDescriptionLabel()
        layoutFirstImageView()
        layoutSecondImageView()
    }
    
    func layoutScrollView() {
        addSubview(scrollView)
        scrollView.pin(.leading, to: .leading, of: self)
        scrollView.pin(.trailing, to: .trailing, of: self)
        scrollView.pin(.top, to: .top, of: self)
        scrollView.pin(.bottom, to: .bottom, of: self)
    }
    
    func layoutScrollableContentView() {
        scrollView.addSubview(scrollableContentView)
        scrollableContentView.pin(.leading, to: .leading, of: scrollView)
        scrollableContentView.pin(.trailing, to: .trailing, of: scrollView)
        scrollableContentView.pin(.top, to: .top, of: scrollView)
        scrollableContentView.pin(.bottom, to: .bottom, of: scrollView)
        scrollableContentView.pin(.width, to: .width, of: safeAreaLayoutGuide)
    }
    
    func layoutDescriptionLabel() {
        scrollableContentView.addSubview(descriptionLabel)
        descriptionLabel.pin(.leading, to: .leading, of: scrollableContentView, constant: Spacings.standard)
        descriptionLabel.pin(.trailing, to: .trailing, of: scrollableContentView, constant: -Spacings.standard)
        descriptionLabel.pin(.top, to: .top, of: scrollableContentView, constant: Spacings.standard)
    }
    
    func layoutFirstImageView() {
        scrollableContentView.addSubview(firstImageView)
        firstImageView.pin(.leading, to: .leading, of: scrollableContentView, constant: Spacings.large)
        firstImageView.pin(.trailing, to: .trailing, of: scrollableContentView, constant: -Spacings.large)
        firstImageView.pin(.top, to: .bottom, of: descriptionLabel, constant: Spacings.large)
        firstImageView.pin(.width, to: .height, of: firstImageView, multiplier: 16 / 9)
    }
    
    func layoutSecondImageView() {
        scrollableContentView.addSubview(secondImageView)
        secondImageView.pin(.leading, to: .leading, of: scrollableContentView, constant: Spacings.large)
        secondImageView.pin(.trailing, to: .trailing, of: scrollableContentView, constant: -Spacings.large)
        secondImageView.pin(.top, to: .bottom, of: firstImageView, constant: Spacings.large)
        secondImageView.pin(.bottom, to: .bottom, of: scrollView, constant: -Spacings.large)
        secondImageView.pin(.width, to: .height, of: secondImageView, multiplier: 16 / 9)
    }
    
}
