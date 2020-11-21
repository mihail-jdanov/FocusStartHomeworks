//
//  CarsPresenter.swift
//  Homework5
//
//  Created by Михаил Жданов on 14.11.2020.
//

protocol ICarsPresenter {
    
    var cars: [ICar] { get }
    
    init(model: ICarsModel)
    
    func deleteCar(atIndex index: Int)
    
}

final class CarsPresenter: ICarsPresenter {
    
    // MARK: - Properties
    
    weak var view: ICarsView?
    
    var cars: [ICar] {
        return model.cars
    }
    
    // MARK: - Private properties
    
    private let model: ICarsModel
    
    // MARK: - Init
    
    init(model: ICarsModel) {
        self.model = model
    }
    
    // MARK: - Methods
    
    func deleteCar(atIndex index: Int) {
        model.deleteCar(atIndex: index)
    }
    
}
