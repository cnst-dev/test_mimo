//
//  LoginButton.swift
//  MimoiOSCodingChallenge
//
//  Created by Konstantin Khokhlov on 14.07.17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import UIKit

class LoginButton: UIButton, Constraintable {

    var width = 150
    var height = 50

    /// Setups a button for the login screen.
    ///
    /// - Parameter title: The title string.
    func setup(title: String, width: Int, height: Int) {
        setTitle(title, for: .normal)
        self.width = width
        self.height = height
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor.lightGray
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 3
        translatesAutoresizingMaskIntoConstraints = false
    }
}
