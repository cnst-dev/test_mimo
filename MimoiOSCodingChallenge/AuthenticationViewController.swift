//
//  AuthenticationViewController.swift
//  MimoiOSCodingChallenge
//
//  Created by Konstantin Khokhlov on 14.07.17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    // MARK: - Outlets
    let mailTextField = LoginTextField()
    let passwordTextField = LoginTextField()
    let submitButton = LoginButton()

    // MARK: - Properties
    let authManager: (AuthControllerDelegate & UserDataSource) = NetworkClient.shared


    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    /// Logins a user with his email and password.
    func login() {
        guard let mail = mailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        authManager.login(mail: mail, password: password, success: { [weak self] dictionary in
            print("SUCCESS LOGIN", dictionary)

            self?.authManager.getUserInfo(success: { dictionary in
                print("USER INFO SUCCESS", dictionary)
            }, failure: { message in
                print("ERROR USER INFO", message)
            })

        }) { message in
            print("ERROR LOGIN", message)
        }

    }

    /// Registers a user with his email and password.
    func register() {
        guard let mail = mailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        authManager.register(mail: mail, password: password, success: { dict in
            print("SUCCESS REGISTER", dict)
        }) { message in
            print("ERROR REGISTER", message)
        }
    }

    /// Setups text fields and a button in the view.
    func setupView() {

        view.addSubview(mailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(submitButton)

        view.backgroundColor = UIColor.white

        mailTextField.setup(placeholder: "E-mail", width: 150, height: 30)
        mailTextField.keyboardType = .emailAddress
        passwordTextField.setup(placeholder: "Password", width: 150, height: 30)
        passwordTextField.isSecureTextEntry = true
        submitButton.setup(title: "Submit", width: 150, height: 50)

        submitButton.addTarget(self, action: #selector(login), for: .touchUpInside)

        let mailTextFieldKey = #keyPath(mailTextField)
        let passwordTextFieldKey = #keyPath(passwordTextField)
        let submitButtonKey = #keyPath(submitButton)

        let views = [
            mailTextFieldKey: mailTextField,
            passwordTextFieldKey: passwordTextField,
            submitButtonKey: submitButton
        ]

        var constraints = [NSLayoutConstraint]()

        // Sets in the center
        constraints.append(mailTextField.centerContsraint)
        constraints.append(passwordTextField.centerContsraint)
        constraints.append(submitButton.centerContsraint)

        // Sets the width
        constraints.append(contentsOf: mailTextField.widthConstraints(for: mailTextFieldKey))
        constraints.append(contentsOf: passwordTextField.widthConstraints(for: passwordTextFieldKey))
        constraints.append(contentsOf: submitButton.widthConstraints(for: submitButtonKey))

        // Sets the height
        constraints.append(contentsOf: mailTextField.heightConstraints(for: mailTextFieldKey))
        constraints.append(contentsOf: passwordTextField.heightConstraints(for: passwordTextFieldKey))
        constraints.append(contentsOf: submitButton.heightConstraints(for: submitButtonKey))

        // Sets a vertical positions
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-200-[\(mailTextFieldKey)]-[\(passwordTextFieldKey)]-[\(submitButtonKey)]",
            options: [],
            metrics: nil,
            views: views
        ))
        
        NSLayoutConstraint.activate(constraints)
    }
}
