//
//  ThirdView.swift
//  Homework3
//
//  Created by Михаил Жданов on 02.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

class ThirdView: UIView {
    
    // MARK: - Properties
    
    weak var parentViewController: UIViewController?
    
    private let enterButtonDefaultBottomSpacing = Spacings.standard
    
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
        layoutViews()
        addKeyboardObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
    
    // MARK: - Private methods
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let tabBarHeight = parentViewController?.tabBarController?.tabBar.frame.height ?? 0
        let spacing = keyboardSize.height - tabBarHeight + enterButtonDefaultBottomSpacing
        setEnterButtonBottomSpace(-spacing)
    }
    
    @objc
    private func keyboardWillHide(_ notification: NSNotification) {
        setEnterButtonBottomSpace(-enterButtonDefaultBottomSpacing)
    }
    
    private func setEnterButtonBottomSpace(_ spacing: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.enterButtonBottomConstraint?.constant = spacing
            self.layoutIfNeeded()
        }
    }

}

private extension ThirdView {
    
    // MARK: - Layout
    
    func layoutViews() {
        layoutLoginTextField()
        layoutPassswordTextField()
        layoutEnterButton()
    }
    
    func layoutLoginTextField() {
        addSubview(loginTextField)
        loginTextField.pin(.leading, to: .leading, of: safeAreaLayoutGuide, constant: Spacings.standard)
        loginTextField.pin(.trailing, to: .trailing, of: safeAreaLayoutGuide, constant: -Spacings.standard)
        loginTextField.pin(.centerY, to: .centerY, of: safeAreaLayoutGuide, multiplier: 0.3)
    }
    
    func layoutPassswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.pin(.leading, to: .leading, of: safeAreaLayoutGuide, constant: Spacings.standard)
        passwordTextField.pin(.trailing, to: .trailing, of: safeAreaLayoutGuide, constant: -Spacings.standard)
        passwordTextField.pin(.centerY, to: .centerY, of: safeAreaLayoutGuide, multiplier: 0.55)
    }
    
    func layoutEnterButton() {
        addSubview(enterButton)
        enterButton.pin(.centerX, to: .centerX, of: safeAreaLayoutGuide)
        enterButton.pin(.width, constant: 200)
        enterButton.pin(.height, constant: 35)
        enterButtonBottomConstraint = enterButton.pin(.bottom, to: .bottom,
            of: safeAreaLayoutGuide, constant: -enterButtonDefaultBottomSpacing)
    }
    
}
