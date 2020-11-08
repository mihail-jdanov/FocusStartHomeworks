//
//  MasterViewController.swift
//  Homework4
//
//  Created by Михаил Жданов on 04.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

protocol MasterViewControllerDelegate: AnyObject {
    
    func masterViewControllerDidSelectArticle(withIndex index: Int)
    
}

class MasterViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: MasterViewControllerDelegate?
    
    private var tableViewData: [Article] {
        return ArticlesProvider().articles
    }
    
    private var lastSelectedRowIndexPath: IndexPath?
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.className)
        return tableView
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Домашнее задание №4"
        layoutTableView()
    }
    
}

extension MasterViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectedRowIndexPath = indexPath
        delegate?.masterViewControllerDidSelectArticle(withIndex: indexPath.row)
        if let detailViewController = delegate as? UIViewController,
            let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
    
}

extension MasterViewController: UITableViewDataSource {
    
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

extension MasterViewController: DetailViewControllerDelegate {
    
    func detailViewControllerNeedsArticle() {
        let firstRowIndexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: firstRowIndexPath, animated: false, scrollPosition: .none)
        lastSelectedRowIndexPath = firstRowIndexPath
        delegate?.masterViewControllerDidSelectArticle(withIndex: firstRowIndexPath.row)
    }
    
    func detailViewControllerWillDisappear() {
        guard let selectedRowIndexPath = tableView.indexPathForSelectedRow else { return }
        tableView.deselectRow(at: selectedRowIndexPath, animated: true)
    }
    
    func detailViewControllerDidAppear() {
        guard let indexPath = lastSelectedRowIndexPath else { return }
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    }
    
}

private extension MasterViewController {
    
    // MARK: - Layout
    
    func layoutTableView() {
        view.addSubview(tableView)
        tableView.pin(.leading, to: .leading, of: view)
        tableView.pin(.trailing, to: .trailing, of: view)
        tableView.pin(.top, to: .top, of: view)
        tableView.pin(.bottom, to: .bottom, of: view)
    }
    
}
