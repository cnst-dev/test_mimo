//
//  UserDataSource.swift
//  MimoiOSCodingChallenge
//
//  Created by Konstantin Khokhlov on 18.07.17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

protocol UserDataSource {

    var user: String? { get set }

    /// Gets user infos from the Auth0.
    ///
    /// - Parameters:
    ///   - success: A closure to call when the request is successed.
    ///   - failure: A closure to call when the request is failed.
    /// - Returns: Void
    func getUserInfo(success: @escaping NetworkClient.Success,
                     failure: @escaping NetworkClient.Failure) -> Void
}
