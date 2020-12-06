//
//  CustomizableView.swift
//  Homework6
//
//  Created by Михаил Жданов on 29.11.2020.
//

import UIKit

class CustomizableViewBuilder {
    
    // MARK: - Properties
    
    var animationsDuration: TimeInterval = 1
    
    // MARK: - Private properties
    
    private let view = CustomizableView()
    
    // MARK: - Methods
    
    func setAlpha(_ alpha: CGFloat, animated: Bool) -> Self {
        let duration = animated ? animationsDuration : 0
        UIView.animate(withDuration: duration) {
            self.view.alpha = alpha
        }
        return self
    }
    
    func setBackground(_ color: UIColor) -> Self {
        view.backgroundColor = color
        return self
    }
    
    func setBackground(_ image: UIImage?) -> Self {
        view.imageView.image = image
        return self
    }
    
    func roundCorners(_ corners: CACornerMask, _ radius: CGFloat) -> Self {
        view.layer.cornerRadius = radius
        view.layer.maskedCorners = corners
        view.imageView.clipsToBounds = true
        view.imageView.layer.cornerRadius = radius
        view.imageView.layer.maskedCorners = corners
        return self
    }
    
    func addShadow(radius: CGFloat, color: UIColor = .black, offset: CGSize = .zero, opacity: Float = 0.75) -> Self {
        view.layer.shadowRadius = radius
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = offset
        view.layer.shadowOpacity = opacity
        return self
    }
    
    func build() -> CustomizableView {
        return view
    }
    
}

class CustomizableView: UIView {
    
    // MARK: - Views

    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CustomizableView {
    
    // MARK: - Configure subviews
    
    func configureImageView() {
        addSubview(imageView)
        imageView.pin(.leading, to: .leading, of: self)
        imageView.pin(.trailing, to: .trailing, of: self)
        imageView.pin(.top, to: .top, of: self)
        imageView.pin(.bottom, to: .bottom, of: self)
    }
    
}
