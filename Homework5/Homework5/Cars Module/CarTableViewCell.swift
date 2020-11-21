//
//  CarTableViewCell.swift
//  Homework5
//
//  Created by Михаил Жданов on 15.11.2020.
//

import UIKit

final class CarTableViewCell: UITableViewCell {
    
    // MARK: - Life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(manufacturer: String, model: String, bodyType: String, yearOfIssue: String) {
        textLabel?.text = manufacturer + " " + model
        detailTextLabel?.text = "\(bodyType), \(yearOfIssue) год выпуска"
    }
    
}
