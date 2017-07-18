//
//  AuthControllerDelegate.swift
//  MimoiOSCodingChallenge
//
//  Created by Konstantin Khokhlov on 18.07.17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

protocol AuthControllerDelegate {

    /// Sends a login request to the Auth0.
    ///
    /// - Parameters:
    ///   - mail: A user email.
    ///   - password: A user password.
    ///   - success: A closure to call when the request is successed.
    ///   - failure: A closure to call when the request is failed.
    /// - Returns: Void.
    func login(mail: String, password: String,
               success: @escaping NetworkClient.Success,
               failure: @escaping NetworkClient.Failure) -> Void

    /// Sends a signup request to the Auth0.
    ///
    /// - Parameters:
    ///   - mail: A user email.
    ///   - password: A user password.
    ///   - success: A closure to call when the request is successed.
    ///   - failure: A closure to call when the request is failed.
    /// - Returns: Void.
    func register(mail: String, password: String,
                  success: @escaping NetworkClient.Success,
                  failure: @escaping NetworkClient.Failure) -> Void
}
