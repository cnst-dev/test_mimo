//
//  LoginTextField.swift
//  MimoiOSCodingChallenge
//
//  Created by Konstantin Khokhlov on 14.07.17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import UIKit

class LoginTextField: UITextField, Constraintable {

    var width = 100
    var height = 30

    /// Setups a text field for the login screen.
    ///
    /// - Parameter placeholder: The placeholder string.
    func setup(placeholder: String, width: Int, height: Int) {
        self.placeholder = placeholder
        self.width = width
        self.height = height
        isSecureTextEntry = false
        textColor = UIColor.black
        backgroundColor = UIColor.white
        borderStyle = .roundedRect
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        translatesAutoresizingMaskIntoConstraints = false
    }
}
