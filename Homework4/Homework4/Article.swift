//
//  Article.swift
//  Homework4
//
//  Created by Михаил Жданов on 04.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import Foundation

struct Article {
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    let title: String
    let description: String?
    let date: Date?
    let text: String
    let firstImageName: String
    let secondImageName: String
    
    var timeString: String? {
        guard let date = date else { return nil }
        return Article.timeFormatter.string(from: date)
    }
    
}
