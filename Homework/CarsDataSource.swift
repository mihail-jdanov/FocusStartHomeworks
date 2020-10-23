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
    
    private(set) var cars: [Car] = [] {
        didSet {
            cars = cars.sorted { $0.manufacturer < $1.manufacturer }
        }
    }
    
    var yearOfIssuePossibleValues: [Int?] {
        let currentYear = Calendar.current.component(.year, from: Date())
        var values: [Int?] = Array(1885 ... currentYear).reversed()
        values.insert(nil, at: 0)
        return values
    }
    
    var bodyPossibleValues: [Body] {
        return Body.allCases
    }
    
    func addCar(_ car: Car) {
        if cars.contains(car) { return }
        cars.append(car)
    }
    
    func replaceCar(byIndex index: Int, with car: Car) {
        guard index >= 0 && index < cars.count else { return }
        cars[index] = car
    }
    
    func removeCar(_ car: Car) {
        cars.removeAll { $0 == car }
    }
    
}
