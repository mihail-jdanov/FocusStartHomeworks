//
//  Article.swift
//  Homework4
//
//  Created by Михаил Жданов on 04.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import Foundation

struct Article {
    
    let title: String
    let description: String?
    let defaultDescription = "У этой статьи нет описания."
    let date: Date?
    let firstImageName: String
    let secondImageName: String
    
    var timeString: String? {
        return DateFormatter.shortTimeString(from: date)
    }
    
}
