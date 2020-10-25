//
//  EditCarAlertController.swift
//  Homework
//
//  Created by Михаил Жданов on 16.10.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class EditCarAlertController: NSObject {
    
    private let yearOfIssuePickerView = UIPickerView()
    private let bodyPickerView = UIPickerView()
    private let maxCharactersCountForTextFields = 30
    
    private var manufacturerTextField: UITextField?
    private var modelTextField: UITextField?
    private var bodyTextField: UITextField?
    private var yearOfIssueTextField: UITextField?
    private var carNumberTextField: UITextField?
    private var saveAlertAction: UIAlertAction?
    
    override init() {
        super.init()
        setupPickerViews()
    }
    
    private func setupPickerViews() {
        yearOfIssuePickerView.delegate = self
        yearOfIssuePickerView.dataSource = self
        bodyPickerView.delegate = self
        bodyPickerView.dataSource = self
    }
    
    private func getPickerViewTitle(_ pickerView: UIPickerView, forRow row: Int) -> String? {
        switch pickerView {
        case yearOfIssuePickerView:
            guard let yearOfIssue = CarsDataSource.shared.yearOfIssuePossibleValues[row] else { return nil }
            return String(yearOfIssue)
        case bodyPickerView:
            return CarsDataSource.shared.bodyPossibleValues[row].stringValue
        default:
            return nil
        }
    }
    
    @objc
    private func validateTextFields() {
        var isValidationPassed = true
        let textFields = [manufacturerTextField, modelTextField, bodyTextField]
        for textField in textFields {
            let text = textField?.text?.trimmingCharacters(in: .whitespaces) ?? ""
            if text.isEmpty || text.count > maxCharactersCountForTextFields {
                isValidationPassed = false
            }
        }
        let carNumber = carNumberTextField?.text?.trimmingCharacters(in: .whitespaces) ?? ""
        if carNumber.count > maxCharactersCountForTextFields { isValidationPassed = false }
        saveAlertAction?.isEnabled = isValidationPassed
    }
    
    private func saveCar(editingCarIndex: Int?) {
        guard let manufacturer = manufacturerTextField?.text?.trimmingCharacters(in: .whitespaces),
            let model = modelTextField?.text?.trimmingCharacters(in: .whitespaces) else { return }
        let bodyIndex = bodyPickerView.selectedRow(inComponent: 0)
        let body = CarsDataSource.shared.bodyPossibleValues[bodyIndex]
        let yearOfIssueIndex = yearOfIssuePickerView.selectedRow(inComponent: 0)
        let yearOfIssue = CarsDataSource.shared.yearOfIssuePossibleValues[yearOfIssueIndex]
        var carNumber = carNumberTextField?.text?.trimmingCharacters(in: .whitespaces)
        if carNumber?.isEmpty == true { carNumber = nil }
        CarsDataSource.shared.addCar(
            withManufacturer: manufacturer,
            model: model,
            body: body,
            yearOfIssue: yearOfIssue,
            carNumber: carNumber,
            replacingCarWithIndex: editingCarIndex
        )
    }
    
    private func fillTextFieldsForCarEditing(editingCarIndex index: Int?) {
        guard let index = index else { return }
        let car = CarsDataSource.shared.cars[index]
        manufacturerTextField?.text = car.manufacturer
        modelTextField?.text = car.model
        bodyTextField?.text = car.body.stringValue
        let bodyTypeIndex = CarsDataSource.shared.bodyPossibleValues.firstIndex(of: car.body) ?? 0
        bodyPickerView.selectRow(bodyTypeIndex, inComponent: 0, animated: false)
        var yearOfIssue: String?
        if let year = car.yearOfIssue {
            yearOfIssue = String(year)
        }
        yearOfIssueTextField?.text = yearOfIssue
        let yearOfIssueIndex = CarsDataSource.shared.yearOfIssuePossibleValues.firstIndex(of: car.yearOfIssue) ?? 0
        yearOfIssuePickerView.selectRow(yearOfIssueIndex, inComponent: 0, animated: false)
        carNumberTextField?.text = car.carNumber
    }
    
    func show(over viewController: UIViewController, editingCarIndex: Int? = nil,
              saveActionCompletion: (() -> Void)?, alertDisappearCompletion: (() -> Void)?) {
        let isNewCar = editingCarIndex == nil
        let alertTitle = isNewCar ? "Добавить автомобиль" : "Редактировать автомобиль"
        let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            self.manufacturerTextField = textField
            textField.placeholder = "Производитель"
            textField.addTarget(self, action: #selector(self.validateTextFields), for: .editingChanged)
        }
        alertController.addTextField { (textField) in
            self.modelTextField = textField
            textField.placeholder = "Модель"
            textField.addTarget(self, action: #selector(self.validateTextFields), for: .editingChanged)
        }
        alertController.addTextField { (textField) in
            self.bodyTextField = textField
            textField.placeholder = "Тип кузова"
            textField.inputView = self.bodyPickerView
            textField.delegate = self
            textField.addTarget(self, action: #selector(self.validateTextFields), for: .editingChanged)
        }
        alertController.addTextField { (textField) in
            self.yearOfIssueTextField = textField
            textField.placeholder = "Год выпуска"
            textField.inputView = self.yearOfIssuePickerView
            textField.delegate = self
        }
        alertController.addTextField { (textField) in
            self.carNumberTextField = textField
            textField.placeholder = "Гос номер"
            textField.addTarget(self, action: #selector(self.validateTextFields), for: .editingChanged)
        }
        fillTextFieldsForCarEditing(editingCarIndex: editingCarIndex)
        let saveActionTitle = isNewCar ? "Добавить" : "Сохранить"
        let saveAction = UIAlertAction(title: saveActionTitle, style: .default) { (_) in
            self.saveCar(editingCarIndex: editingCarIndex)
            saveActionCompletion?()
            alertDisappearCompletion?()
        }
        saveAlertAction = saveAction
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel) { (_) in
            alertDisappearCompletion?()
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        alertController.preferredAction = saveAction
        viewController.present(alertController, animated: true, completion: nil)
        validateTextFields()
    }
    
}

extension EditCarAlertController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return getPickerViewTitle(pickerView, forRow: row) ?? "Не выбрано"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = getPickerViewTitle(pickerView, forRow: row)
        switch pickerView {
        case yearOfIssuePickerView:
            yearOfIssueTextField?.text = title
        case bodyPickerView:
            bodyTextField?.text = title
        default:
            break
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case yearOfIssuePickerView:
            return CarsDataSource.shared.yearOfIssuePossibleValues.count
        case bodyPickerView:
            return CarsDataSource.shared.bodyPossibleValues.count
        default:
            return 0
        }
    }
    
}

extension EditCarAlertController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case yearOfIssueTextField, bodyTextField:
            return false
        default:
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case yearOfIssueTextField:
            let row = yearOfIssuePickerView.selectedRow(inComponent: 0)
            textField.text = getPickerViewTitle(yearOfIssuePickerView, forRow: row)
        case bodyTextField:
            let row = bodyPickerView.selectedRow(inComponent: 0)
            textField.text = getPickerViewTitle(bodyPickerView, forRow: row)
        default:
            break
        }
        validateTextFields()
    }
    
}
