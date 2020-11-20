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
    
    private let masterViewController = MasterViewController()
    private let detailViewController = DetailViewController()
    
    private lazy var masterNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [masterViewController]
        return navigationController
    }()
    
    private lazy var detailNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [detailViewController]
        return navigationController
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setup()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        preferredDisplayMode = .allVisible
        masterViewController.delegate = detailViewController
        detailViewController.delegate = masterViewController
        viewControllers = [masterNavigationController, detailNavigationController]
    }
    
}

extension SplitViewController: UISplitViewControllerDelegate {
    
    // MARK: - UISplitViewControllerDelegate methods
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}
