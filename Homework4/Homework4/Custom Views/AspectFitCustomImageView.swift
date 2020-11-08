//
//  ShadowRoundedImageView.swift
//  Homework4
//
//  Created by Михаил Жданов on 07.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

struct ShadowSettings {
    
    let shadowRadius: CGFloat
    let shadowOpacity: CGFloat
    let shadowColor: UIColor
    let shadowOffset: CGSize
    
    init(radius: CGFloat, opacity: CGFloat, color: UIColor = .black, offset: CGSize = .zero) {
        self.shadowRadius = radius
        self.shadowOpacity = opacity
        self.shadowColor = color
        self.shadowOffset = offset
    }
    
}

class AspectFitCustomImageView: UIView {
    
    // MARK: - Properties
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            roundCorners()
            setupShadow()
        }
    }
    
    var shadow: ShadowSettings = .init(radius: 0, opacity: 0) {
        didSet {
            setupShadow()
        }
    }
    
    var cornerRadius: CGFloat = 0 {
        didSet {
            roundCorners()
        }
    }
    
    private var imageRect: CGRect? {
        guard let image = image else { return nil }
        let boundsScale = bounds.size.width / bounds.size.height
        let imageScale = image.size.width / image.size.height
        var imageRect = self.bounds
        if boundsScale > imageScale {
            imageRect.size.width = imageRect.size.height * imageScale
            imageRect.origin.x = (bounds.size.width - imageRect.size.width) / 2
        } else {
            imageRect.size.height = imageRect.size.width / imageScale
            imageRect.origin.y = (bounds.size.height - imageRect.size.height) / 2
        }
        return imageRect
    }
    
    // MARK: - Views
    
    private let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners()
        setupShadow()
    }
    
    // MARK: - Private methods
    
    private func roundCorners() {
        guard let imageRect = imageRect else { return }
        let path = UIBezierPath(roundedRect: imageRect, cornerRadius: cornerRadius)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        imageView.layer.mask = mask
    }
    
    private func setupShadow() {
        shadowView.layer.shadowRadius = shadow.shadowRadius
        shadowView.layer.shadowOpacity = Float(shadow.shadowOpacity)
        shadowView.layer.shadowColor = shadow.shadowColor.cgColor
        shadowView.layer.shadowOffset = shadow.shadowOffset
        shadowView.layer.shadowPath = UIBezierPath(
            roundedRect: imageRect ?? .zero,
            cornerRadius: cornerRadius
        ).cgPath
    }
    
}

private extension AspectFitCustomImageView {
    
    // MARK: - Layout
    
    func layoutViews() {
        addSubviews()
        layoutShadowView()
        layoutImageView()
    }
    
    func addSubviews() {
        addSubview(shadowView)
        addSubview(imageView)
    }
    
    func layoutShadowView() {
        shadowView.pin(.leading, to: .leading, of: self)
        shadowView.pin(.trailing, to: .trailing, of: self)
        shadowView.pin(.top, to: .top, of: self)
        shadowView.pin(.bottom, to: .bottom, of: self)
    }
    
    func layoutImageView() {
        imageView.pin(.leading, to: .leading, of: self)
        imageView.pin(.trailing, to: .trailing, of: self)
        imageView.pin(.top, to: .top, of: self)
        imageView.pin(.bottom, to: .bottom, of: self)
    }
    
}
