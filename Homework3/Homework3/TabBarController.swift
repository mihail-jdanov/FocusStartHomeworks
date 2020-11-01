//
//  TabBarController.swift
//  Homework3
//
//  Created by Михаил Жданов on 02.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let firstViewController = FirstViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "First", image: UIImage(named: "FirstIcon"), tag: 0)
        let secondViewController = SecondViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Second", image: UIImage(named: "SecondIcon"), tag: 1)
        let thirdViewController = ThirdViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Third", image: UIImage(named: "ThirdIcon"), tag: 2)
        viewControllers = [firstViewController, secondViewController, thirdViewController]
    }

}

