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

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(submitButton)

        view.backgroundColor = UIColor.white

        setupView()
    }

    /// Setups text fields and a button in the view.
    func setupView() {
        mailTextField.setup(placeholder: "E-mail", width: 150, height: 30)
        passwordTextField.setup(placeholder: "Password", width: 150, height: 30)
        submitButton.setup(title: "Submit", width: 150, height: 50)

        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)

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

    func submit() {
        present(SettingsViewController(), animated: true)
    }
}
