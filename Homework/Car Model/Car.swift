//
//  Car.swift
//  Homework
//
//  Created by Михаил Жданов on 15.10.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import Foundation

struct Car {
    
    private let id = UUID().uuidString

    var manufacturer: String
    var model: String
    var body: Body
    var yearOfIssue: Int?
    var carNumber: String?
    
}

extension Car: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
}
