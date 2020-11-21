//
//  ModuleBuilder.swift
//  Homework5
//
//  Created by Михаил Жданов on 15.11.2020.
//

import UIKit

final class ModuleBuilder {
    
    static func createCarsModule() -> UIViewController {
        let model = CarsModel.shared
        let presenter = CarsPresenter(model: model)
        let viewController = CarsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
    
    static func createEditCarModule(editingCarIndex: Int? = nil, saveActionCompletion: (() -> Void)? = nil,
                                    alertDisappearCompletion: (() -> Void)? = nil) -> UIViewController {
        let model = CarsModel.shared
        let presenter = EditCarPresenter(model: model)
        let viewController = EditCarAlertController(presenter: presenter).prepareAlert(
            editingCarIndex: editingCarIndex,
            saveActionCompletion: saveActionCompletion,
            alertDisappearCompletion: alertDisappearCompletion
        )
        return viewController
    }
    
}
