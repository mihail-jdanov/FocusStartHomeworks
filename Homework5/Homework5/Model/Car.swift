//
//  Car.swift
//  Homework5
//
//  Created by Михаил Жданов on 19.09.2020.
//

import Foundation

protocol ICar {
    
    var manufacturer: String { get }
    var model: String { get }
    var yearOfIssue: Int { get }
    var bodyType: BodyType { get }
    
}

struct Car: ICar {
    
    let managedCar: ManagedCar
    
    var manufacturer: String {
        return managedCar.manufacturer ?? ""
    }
    
    var model: String {
        return managedCar.model ?? ""
    }
    
    var yearOfIssue: Int {
        return Int(managedCar.yearOfIssue)
    }
    
    var bodyType: BodyType {
        return BodyType(rawValue: Int(managedCar.bodyType)) ?? BodyType.allCases[0]
    }
    
}
