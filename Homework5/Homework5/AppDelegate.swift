//
//  AppDelegate.swift
//  Homework5
//
//  Created by Михаил Жданов on 18.09.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let navigationController = UINavigationController()
        let carsViewController = ModuleBuilder.createCarsModule()
        navigationController.viewControllers = [carsViewController]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

