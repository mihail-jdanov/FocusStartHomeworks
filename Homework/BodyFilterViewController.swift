//
//  BodyFilterViewController.swift
//  Homework
//
//  Created by Михаил Жданов on 17.10.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

protocol BodyFilterViewControllerDelegate: class {
    
    func bodyFilterViewControllerDidSetNewBody(_ body: Body?)
    
}

class BodyFilterViewController: UIViewController {
    
    private let cellReuseId = "BodyCell"
    
    var selectedBody: Body?
    
    weak var delegate: BodyFilterViewControllerDelegate?
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func resetButtonAction(_ sender: Any) {
        delegate?.bodyFilterViewControllerDidSetNewBody(nil)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

}

extension BodyFilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Body.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
        let bodyForCell = Body.allCases[indexPath.row]
        cell.textLabel?.text = bodyForCell.stringValue
        if bodyForCell == selectedBody { cell.accessoryType = .checkmark }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for cell in tableView.visibleCells { cell.accessoryType = .none }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let selectedBody = Body.allCases[indexPath.row]
        delegate?.bodyFilterViewControllerDidSetNewBody(selectedBody)
        dismiss(animated: true, completion: nil)
    }
    
}
