//
//  SplitViewController.swift
//  Homework4
//
//  Created by Михаил Жданов on 04.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {
    
    // MARK: - View controllers
    
    private lazy var mainNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [menuViewController]
        return navigationController
    }()
    
    private let menuViewController = MenuViewController()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        preferredDisplayMode = .allVisible
        viewControllers = [mainNavigationController]
    }

}
