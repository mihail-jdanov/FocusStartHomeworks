//
//  CarsDataSource.swift
//  Homework
//
//  Created by Михаил Жданов on 16.10.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import Foundation

final class CarsDataSource {
    
    static let shared = CarsDataSource()
    
    var cars: [Car] = []
    
    var yearOfIssuePossibleValues: [Int?] {
        let currentYear = Calendar.current.component(.year, from: Date())
        var values: [Int?] = Array(1885 ... currentYear).reversed()
        values.insert(nil, at: 0)
        return values
    }
    
    var bodyPossibleValues: [Body] {
        return Body.allCases
    }
    
}
