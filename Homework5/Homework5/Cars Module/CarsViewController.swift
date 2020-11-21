//
//  CarsViewController.swift
//  Homework5
//
//  Created by Михаил Жданов on 14.11.2020.
//

import UIKit

protocol ICarsView: AnyObject {
    
    init(presenter: ICarsPresenter)
    
}

final class CarsViewController: UIViewController, ICarsView {
    
    private enum Constants {
        static let animationDuration: TimeInterval = 0.5
        static let largeSpacing: CGFloat = 32
    }
    
    // MARK: - Private properties
    
    private let presenter: ICarsPresenter
        
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.className)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let emptyCarsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0.5
        label.text = "Нет автомобилей"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(deleteButtonAction)
        )
    }()
    
    private lazy var doneBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(deleteButtonAction)
        )
    }()
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCarButtonAction))
    }()
    
    // MARK: - Life cycle
    
    init(presenter: ICarsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        title = "Автомобили"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        updateEmptyLabelAndDeleteButtonVisibility(animated: false)
    }
    
    // MARK: - Private methods
    
    @objc
    private func deleteButtonAction() {
        let isEditing = !tableView.isEditing
        navigationItem.leftBarButtonItem = isEditing ? doneBarButtonItem : deleteBarButtonItem
        tableView.setEditing(isEditing, animated: true)
    }
    
    @objc
    private func addCarButtonAction() {
        let alertController = ModuleBuilder.createEditCarModule(saveActionCompletion: {
            self.tableView.reloadSections([0], with: .fade)
            self.updateEmptyLabelAndDeleteButtonVisibility(animated: true)
        })
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateEmptyLabelAndDeleteButtonVisibility(animated: Bool) {
        let duration = animated ? Constants.animationDuration : 0
        UIView.animate(withDuration: duration) {
            self.emptyCarsLabel.alpha = self.presenter.cars.isEmpty ? 1 : 0
        }
        if presenter.cars.isEmpty {
            navigationItem.leftBarButtonItem = nil
            DispatchQueue.main.async {
                self.tableView.isEditing = false
            }
        } else {
            navigationItem.leftBarButtonItem = tableView.isEditing ? doneBarButtonItem : deleteBarButtonItem
        }
    }
    
}

extension CarsViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = ModuleBuilder.createEditCarModule(
            editingCarIndex: indexPath.row,
            saveActionCompletion: {
                tableView.reloadSections([0], with: .fade)
            }, alertDisappearCompletion: {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        )
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .delete
        }
        return .none
    }
    
}

extension CarsViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.className, for: indexPath)
        guard let carCell = cell as? CarTableViewCell else { return cell }
        let car = presenter.cars[indexPath.row]
        carCell.configure(
            manufacturer: car.manufacturer,
            model: car.model,
            bodyType: car.bodyType.stringValue,
            yearOfIssue: "\(car.yearOfIssue)"
        )
        return carCell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        presenter.deleteCar(atIndex: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        updateEmptyLabelAndDeleteButtonVisibility(animated: true)
    }
    
}

private extension CarsViewController {
    
    // MARK: - Views configuration
    
    func configureSubviews() {
        addSubviews()
        configureTableView()
        configureEmptyCarsLabel()
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(emptyCarsLabel)
    }
    
    func configureTableView() {
        tableView.pin(.leading, to: .leading, of: view)
        tableView.pin(.trailing, to: .trailing, of: view)
        tableView.pin(.top, to: .top, of: view)
        tableView.pin(.bottom, to: .bottom, of: view)
    }
    
    func configureEmptyCarsLabel() {
        emptyCarsLabel.pin(.centerY, to: .centerY, of: view.safeAreaLayoutGuide)
        emptyCarsLabel.pin(.leading, to: .leading, of: view.safeAreaLayoutGuide, constant: Constants.largeSpacing)
        emptyCarsLabel.pin(.trailing, to: .trailing, of: view.safeAreaLayoutGuide, constant: -Constants.largeSpacing)
    }
    
}
