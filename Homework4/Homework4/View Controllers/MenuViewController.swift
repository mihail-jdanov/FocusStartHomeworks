//
//  MenuViewController.swift
//  Homework4
//
//  Created by Михаил Жданов on 04.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: Properties
    
    private var tableViewData: [Article] {
        return ArticlesProvider.data
    }
    
    // MARK: Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.className)
        return tableView
    }()
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Домашнее задание №4"
        layoutViews()
    }
    
}

extension MenuViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate methods
    
    
    
}

extension MenuViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.className, for: indexPath)
        guard let cell = tableViewCell as? MenuTableViewCell else { return tableViewCell }
        let data = tableViewData[indexPath.row]
        cell.configure(withTitle: data.title, description: data.description, timeText: data.timeString)
        return cell
    }
    
}

private extension MenuViewController {
    
    // MARK: - Layout
    
    func layoutViews() {
        layoutTableView()
    }
    
    func layoutTableView() {
        view.addSubview(tableView)
        tableView.pin(.leading, to: .leading, of: view)
        tableView.pin(.trailing, to: .trailing, of: view)
        tableView.pin(.top, to: .top, of: view)
        tableView.pin(.bottom, to: .bottom, of: view)
    }
    
}
