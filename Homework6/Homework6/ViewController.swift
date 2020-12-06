//
//  ViewController.swift
//  Homework6
//
//  Created by Михаил Жданов on 29.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var customizableView: CustomizableView = {
        let view = CustomizableViewBuilder()
            .setBackground(.systemBlue)
            .setBackground(UIImage(named: "BlackLines"))
            .setAlpha(0, animated: false)
            .setAlpha(1, animated: true)
            .roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner], 30)
            .addShadow(radius: 16)
            .build()
        return view
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureCustomizableView()
    }

}

private extension ViewController {
    
    // MARK: - Configure subviews
    
    func configureCustomizableView() {
        view.addSubview(customizableView)
        customizableView.pin(.width, constant: 200)
        customizableView.pin(.height, constant: 200)
        customizableView.pin(.centerX, to: .centerX, of: view)
        customizableView.pin(.centerY, to: .centerY, of: view)
    }
    
}
