//
//  CarsModel.swift
//  Homework5
//
//  Created by Михаил Жданов on 18.09.2020.
//

import Foundation

protocol ICarsModel {
    
    var yearOfIssueValues: [Int] { get }
    var bodyTypeValues: [BodyType] { get }
    var cars: [ICar] { get }
    
    func addNewCar(manufacturer: String, model: String, yearOfIssue: Int, bodyType: BodyType)
    func deleteCar(atIndex index: Int)
    func updateCar(atIndex index: Int, manufacturer: String, model: String, yearOfIssue: Int, bodyType: BodyType)
    
}

final class CarsModel: ICarsModel {
    
    // MARK: - Singleton instance
    
    static let shared = CarsModel()
    
    // MARK: - Properties
    
    var yearOfIssueValues: [Int] {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array(1885 ... currentYear).reversed()
    }
    
    var bodyTypeValues: [BodyType] {
        return BodyType.allCases
    }
    
    var cars: [ICar] {
        return privateCars
    }
    
    private lazy var privateCars: [Car] = {
        createDefaultCarsIfNeeded()
        guard let managedCars = coreDataService.fetchObjects(ofType: ManagedCar.self) else { return [] }
        return managedCars.map { Car(managedCar: $0) }
    }()
    
    // MARK: - Private properties
    
    private let coreDataService = CoreDataService()
    
    private var isDefaultCarsCreated: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "IsDefaultCarsCreated")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "IsDefaultCarsCreated")
        }
    }
    
    // MARK: - Life cycle
    
    private init() {}
    
    // MARK: - Methods
    
    func addNewCar(manufacturer: String, model: String, yearOfIssue: Int, bodyType: BodyType) {
        let managedCar = ManagedCar(context: coreDataService.context)
        managedCar.manufacturer = manufacturer
        managedCar.model = model
        managedCar.yearOfIssue = Int16(yearOfIssue)
        managedCar.bodyType = Int16(bodyType.rawValue)
        coreDataService.saveContext()
        let car = Car(managedCar: managedCar)
        privateCars.append(car)
    }
    
    func deleteCar(atIndex index: Int) {
        let managedCar = privateCars.remove(at: index).managedCar
        coreDataService.context.delete(managedCar)
        coreDataService.saveContext()
    }
    
    func updateCar(atIndex index: Int, manufacturer: String, model: String, yearOfIssue: Int, bodyType: BodyType) {
        let managedCar = privateCars[index].managedCar
        managedCar.manufacturer = manufacturer
        managedCar.model = model
        managedCar.yearOfIssue = Int16(yearOfIssue)
        managedCar.bodyType = Int16(bodyType.rawValue)
        coreDataService.saveContext()
    }
    
    // MARK: - Private methods
    
    private func createDefaultCarsIfNeeded() {
        if isDefaultCarsCreated { return }
        isDefaultCarsCreated = true
        let car1 = ManagedCar(context: coreDataService.context)
        car1.manufacturer = "Mitsubishi"
        car1.model = "Outlander"
        car1.yearOfIssue = 2012
        car1.bodyType = Int16(BodyType.sportUtilityVehicle.rawValue)
        let car2 = ManagedCar(context: coreDataService.context)
        car2.manufacturer = "Nissan"
        car2.model = "Tiida"
        car2.yearOfIssue = 2009
        car2.bodyType = Int16(BodyType.hatchback.rawValue)
        let car3 = ManagedCar(context: coreDataService.context)
        car3.manufacturer = "Toyota"
        car3.model = "Vista"
        car3.yearOfIssue = 1994
        car3.bodyType = Int16(BodyType.sedan.rawValue)
        coreDataService.saveContext()
    }
    
}
