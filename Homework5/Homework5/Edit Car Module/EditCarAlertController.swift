//
//  EditCarAlertController.swift
//  Homework5
//
//  Created by Михаил Жданов on 19.09.2020.
//

import UIKit

protocol IEditCarView: AnyObject {
    
    init(presenter: IEditCarPresenter)
    
}

class EditCarAlertController: NSObject, IEditCarView {
    
    // MARK: - Private properties
    
    private let presenter: IEditCarPresenter
    private let yearOfIssuePickerView = UIPickerView()
    private let bodyTypePickerView = UIPickerView()
    private let maxCharactersCountForTextFields = 30
    
    private var manufacturerTextField: UITextField?
    private var modelTextField: UITextField?
    private var yearOfIssueTextField: UITextField?
    private var bodyTypeTextField: UITextField?
    private var saveAlertAction: UIAlertAction?
    
    // MARK: - Life cycle
    
    required init(presenter: IEditCarPresenter) {
        self.presenter = presenter
        super.init()
        setupPickerViews()
    }
    
    // MARK: - Methods
    
    func prepareAlert(editingCarIndex: Int? = nil, saveActionCompletion: (() -> Void)?,
                      alertDisappearCompletion: (() -> Void)?) -> UIAlertController {
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
            self.yearOfIssueTextField = textField
            textField.placeholder = "Год выпуска"
            textField.inputView = self.yearOfIssuePickerView
            textField.delegate = self
            textField.addTarget(self, action: #selector(self.validateTextFields), for: .editingChanged)
        }
        alertController.addTextField { (textField) in
            self.bodyTypeTextField = textField
            textField.placeholder = "Тип кузова"
            textField.inputView = self.bodyTypePickerView
            textField.delegate = self
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
        validateTextFields()
        return alertController
    }
    
    // MARK: - Private methods
    
    private func setupPickerViews() {
        yearOfIssuePickerView.delegate = self
        yearOfIssuePickerView.dataSource = self
        bodyTypePickerView.delegate = self
        bodyTypePickerView.dataSource = self
    }
    
    private func getPickerViewTitle(_ pickerView: UIPickerView, forRow row: Int) -> String? {
        switch pickerView {
        case yearOfIssuePickerView:
            return String(presenter.yearOfIssueValues[row])
        case bodyTypePickerView:
            return presenter.bodyTypeValues[row].stringValue
        default:
            return nil
        }
    }
    
    @objc
    private func validateTextFields() {
        var isValidationPassed = true
        let textFields = [manufacturerTextField, modelTextField, yearOfIssueTextField, bodyTypeTextField]
        for textField in textFields {
            let text = textField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            if text.isEmpty || text.count > maxCharactersCountForTextFields {
                isValidationPassed = false
            }
        }
        saveAlertAction?.isEnabled = isValidationPassed
    }
    
    private func saveCar(editingCarIndex: Int?) {
        let yearOfIssueIndex = yearOfIssuePickerView.selectedRow(inComponent: 0)
        let bodyTypeIndex = bodyTypePickerView.selectedRow(inComponent: 0)
        let manufacturer = manufacturerTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let model = modelTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let yearOfIssue = presenter.yearOfIssueValues[yearOfIssueIndex]
        let bodyType = presenter.bodyTypeValues[bodyTypeIndex]
        presenter.saveCar(
            editingCarIndex: editingCarIndex,
            manufacturer: manufacturer,
            model: model,
            yearOfIssue: yearOfIssue,
            bodyType: bodyType
        )
    }
    
    private func fillTextFieldsForCarEditing(editingCarIndex index: Int?) {
        guard let index = index else { return }
        let car = presenter.cars[index]
        manufacturerTextField?.text = car.manufacturer
        modelTextField?.text = car.model
        yearOfIssueTextField?.text = String(car.yearOfIssue)
        bodyTypeTextField?.text = car.bodyType.stringValue
        let yearOfIssueIndex = presenter.yearOfIssueValues.firstIndex(of: car.yearOfIssue) ?? 0
        yearOfIssuePickerView.selectRow(yearOfIssueIndex, inComponent: 0, animated: false)
        let bodyTypeIndex = presenter.bodyTypeValues.firstIndex(of: car.bodyType) ?? 0
        bodyTypePickerView.selectRow(bodyTypeIndex, inComponent: 0, animated: false)
    }
    
}

extension EditCarAlertController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return getPickerViewTitle(pickerView, forRow: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = getPickerViewTitle(pickerView, forRow: row)
        switch pickerView {
        case yearOfIssuePickerView:
            yearOfIssueTextField?.text = title
        case bodyTypePickerView:
            bodyTypeTextField?.text = title
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
            return presenter.yearOfIssueValues.count
        case bodyTypePickerView:
            return presenter.bodyTypeValues.count
        default:
            return 0
        }
    }
    
}

extension EditCarAlertController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case yearOfIssueTextField, bodyTypeTextField:
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
        case bodyTypeTextField:
            let row = bodyTypePickerView.selectedRow(inComponent: 0)
            textField.text = getPickerViewTitle(bodyTypePickerView, forRow: row)
        default:
            break
        }
        validateTextFields()
    }
    
}
