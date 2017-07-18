//
//  AuthControllerDataSource.swift
//  MimoiOSCodingChallenge
//
//  Created by Konstantin Khokhlov on 18.07.17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation

protocol AuthControllerDataSource {

    var token: String? { get set }
}
