//
//  SecondViewController.swift
//  Homework3
//
//  Created by Михаил Жданов on 02.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    // MARK: - Life cycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func loadView() {
        view = SecondView()
    }

}
