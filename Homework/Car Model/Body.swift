//
//  Body.swift
//  Homework
//
//  Created by Михаил Жданов on 15.10.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import Foundation

enum Body: Int, CaseIterable {
    
    case sedan
    case coupe
    case sportsCar
    case stationWagon
    case hatchback
    case convertible
    case sportUtilityVehicle
    case minivan
    case pickupTruck
    
    var stringValue: String {
        switch self {
        case .sedan:
            return "Седан"
        case .coupe:
            return "Купе"
        case .sportsCar:
            return "Спорткар"
        case .stationWagon:
            return "Универсал"
        case .hatchback:
            return "Хэтчбек"
        case .convertible:
            return "Кабриолет"
        case .sportUtilityVehicle:
            return "Внедорожник"
        case .minivan:
            return "Минивэн"
        case .pickupTruck:
            return "Пикап"
        }
    }
    
}
