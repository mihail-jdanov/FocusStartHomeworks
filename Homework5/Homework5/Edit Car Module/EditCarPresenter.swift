//
//  EditCarPresenter.swift
//  Homework5
//
//  Created by Михаил Жданов on 15.11.2020.
//

protocol IEditCarPresenter {
    
    var cars: [ICar] { get }
    var yearOfIssueValues: [Int] { get }
    var bodyTypeValues: [BodyType] { get }
    
    init(model: ICarsModel)
    
    func saveCar(editingCarIndex: Int?, manufacturer: String, model: String, yearOfIssue: Int, bodyType: BodyType)
    
}

final class EditCarPresenter: IEditCarPresenter {
    
    // MARK: - Properties
    
    weak var view: IEditCarView?
    
    var cars: [ICar] {
        return model.cars
    }
    
    var yearOfIssueValues: [Int] {
        return model.yearOfIssueValues
    }
    
    var bodyTypeValues: [BodyType] {
        return model.bodyTypeValues
    }
    
    // MARK: - Private properties
    
    private let model: ICarsModel
    
    // MARK: - Init
    
    init(model: ICarsModel) {
        self.model = model
    }
    
    // MARK: - Methods
    
    func saveCar(editingCarIndex: Int?, manufacturer: String, model: String, yearOfIssue: Int, bodyType: BodyType) {
        if let index = editingCarIndex {
            self.model.updateCar(
                atIndex: index,
                manufacturer: manufacturer,
                model: model,
                yearOfIssue: yearOfIssue,
                bodyType: bodyType
            )
        } else {
            self.model.addNewCar(
                manufacturer: manufacturer,
                model: model,
                yearOfIssue: yearOfIssue,
                bodyType: bodyType
            )
        }
    }
    
}
