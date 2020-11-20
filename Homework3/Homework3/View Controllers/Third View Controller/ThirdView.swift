//
//  ThirdView.swift
//  Homework3
//
//  Created by Михаил Жданов on 02.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class ThirdView: UIView {
    
    private enum Constants {
        static let smallSpacing: CGFloat = 8
        static let standardSpacing: CGFloat = 16
        static let enterButtonWidth: CGFloat = 200
        static let enterButtonHeight: CGFloat = 35
    }
    
    // MARK: - Properties
    
    weak var parentViewController: UIViewController?
    
    private var enterButtonBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Views
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Login"
        textField.borderStyle = .roundedRect
        textField.overrideUserInterfaceStyle = .light
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.overrideUserInterfaceStyle = .light
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("Enter", for: .normal)
        return button
    }()

    // MARK: - Life cycle

    init(frame: CGRect = .zero, parentViewController: UIViewController? = nil) {
        self.parentViewController = parentViewController
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "#ffda75")
        configureSubviews()
        addKeyboardObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }

}

private extension ThirdView {
    
    // MARK: - Private methods
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let tabBarHeight = parentViewController?.tabBarController?.tabBar.frame.height ?? 0
        let spacing = keyboardSize.height - tabBarHeight + Constants.standardSpacing
        setEnterButtonBottomSpace(-spacing)
    }
    
    @objc
    func keyboardWillHide(_ notification: NSNotification) {
        setEnterButtonBottomSpace(-Constants.standardSpacing)
    }
    
    func setEnterButtonBottomSpace(_ spacing: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.enterButtonBottomConstraint?.constant = spacing
            self.layoutIfNeeded()
        }
    }
    
}

private extension ThirdView {
    
    // MARK: - Views configuration
    
    func configureSubviews() {
        addSubviews()
        configureLoginTextField()
        configurePassswordTextField()
        configureEnterButton()
    }
    
    func addSubviews() {
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(enterButton)
    }
    
    func configureLoginTextField() {
        loginTextField.pin(.leading, to: .leading, of: safeAreaLayoutGuide, constant: Constants.standardSpacing)
        loginTextField.pin(.trailing, to: .trailing, of: safeAreaLayoutGuide, constant: -Constants.standardSpacing)
        loginTextField.pin(.centerY, to: .centerY, of: safeAreaLayoutGuide, multiplier: 0.3)
    }
    
    func configurePassswordTextField() {
        passwordTextField.pin(.leading, to: .leading, of: safeAreaLayoutGuide, constant: Constants.standardSpacing)
        passwordTextField.pin(.trailing, to: .trailing, of: safeAreaLayoutGuide, constant: -Constants.standardSpacing)
        passwordTextField.pin(.centerY, to: .centerY, of: safeAreaLayoutGuide, multiplier: 0.55)
    }
    
    func configureEnterButton() {
        enterButton.pin(.centerX, to: .centerX, of: safeAreaLayoutGuide)
        enterButton.pin(.width, constant: Constants.enterButtonWidth)
        enterButton.pin(.height, constant: Constants.enterButtonHeight)
        enterButtonBottomConstraint = enterButton.pin(.bottom,
                                                      to: .bottom,
                                                      of: safeAreaLayoutGuide,
                                                      constant: -Constants.standardSpacing)
    }
    
}
