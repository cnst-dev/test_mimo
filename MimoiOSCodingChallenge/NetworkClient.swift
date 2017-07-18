//
//  NetworkClient.swift
//  MimoiOSCodingChallenge
//
//  Created by Konstantin Khokhlov on 17.07.17.
//  Copyright © 2017 Mimohello GmbH. All rights reserved.
//

import Foundation
import Alamofire

enum RequestType: String {
    case login = "oauth/ro", sign = "dbconnections/signup", user = "userinfo"
}

class NetworkClient {

    // MARK: - Nested
    fileprivate enum Keys: String {
        case token = "access_token", user
    }

    // MARK: - Properties
    private let baseURL: URL
    private var headers = ["Content-Type": "application/json"]


    /// A closure to call when the request is successed.
    typealias Success = ([String: Any]) -> Void
    /// A closure to call when the request is failed.
    typealias Failure = ([String: Any]) -> Void

    fileprivate var defaults: UserDefaults {
        return UserDefaults.standard
    }

    /// Returns the shared NetworkClient object.
    static let shared: NetworkClient = {
        guard let file = Bundle.main.path(forResource: "ServerSettings", ofType: "plist") else {
            fatalError("There should be a settings file")
        }

        guard let dictionary = NSDictionary(contentsOfFile: file),
            let urlString = dictionary["base_url"] as? String,
            let url = URL(string: urlString) else {
            fatalError("There should be an URL")
        }

        return NetworkClient(baseURL: url)
    }()

    // MARK: - Init
    init(baseURL: URL) {
        self.baseURL = baseURL
    }


    /// Creates a request to the Auth0.
    ///
    /// - Parameters:
    ///   - requestType: A string to append as a path component.
    ///   - method: A HTTP method.
    ///   - parameters: A parameters dictionary.
    ///   - success: A closure to call when the request is successed.
    ///   - failure: A closure to call when the request is successed.
    fileprivate func request(requestType: RequestType,
                         method: HTTPMethod,
                         parameters: [String: String]? = nil,
                         success: @escaping Success,
                         failure: @escaping Failure) {
        let queue = DispatchQueue(label: "test-auth", qos: .userInitiated)

        let url = baseURL.appendingPathComponent(requestType.rawValue)

        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }

        Alamofire.request(
            url, method: method,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers).responseJSON(
                queue: queue,
                options: .allowFragments) { response in

                    switch(response.result) {
                    case .success(let value):
                        guard let dictionary =  value as? [String: Any] else {
                            fatalError("There should be a dictionary")
                        }

                        if let statusCode = response.response?.statusCode,
                            200 <= statusCode && statusCode < 300 {
                            success(dictionary)
                        } else {
                            failure(dictionary)
                        }
                    case .failure(let error):
                        failure(["error_description": error.localizedDescription])
                    }
        }
    }
}

// MARK: - AuthControllerDelegate
extension NetworkClient: AuthControllerDelegate {

    func login(mail: String, password: String,
               success: @escaping Success,
               failure: @escaping Failure) {

        let parameters = [
            "client_id": "PAn11swGbMAVXVDbSCpnITx5Utsxz1co",
            "username": mail,
            "password": password,
            "connection": "Username-Password-Authentication",
            "scope": "openid profile email",
            "grant_type": "password"]
        
        request(requestType: .login, method: .post,
                parameters: parameters,
                success: { [weak self] dictionary in
                    self?.token = dictionary[Keys.token.rawValue] as? String
                    success(dictionary)
        }) { message in
            failure(message)
        }
    }

    func register(mail: String, password: String,
                  success: @escaping Success,
                  failure: @escaping Failure) {

        let parameters = [
            "client_id": "PAn11swGbMAVXVDbSCpnITx5Utsxz1co",
            "email": mail,
            "password": password,
            "connection": "Username-Password-Authentication"]

        request(requestType: .sign, method: .post,
                parameters: parameters,
                success: { dictionary in
                    success(dictionary)
        }) { message in
            failure(message)
        }
    }
}

// MARK: - AuthControllerDataSource
extension NetworkClient: AuthControllerDataSource {

    var token: String? {
        get {
            return defaults.string(forKey: Keys.token.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Keys.token.rawValue)
        }
    }
}

// MARK: - UserDataSource
extension NetworkClient: UserDataSource {

    var user: String? {
        get {
            return defaults.string(forKey: Keys.user.rawValue)
        }
        set {
            defaults.set(newValue, forKey: Keys.user.rawValue)
        }
    }

    func getUserInfo(success: @escaping Success,
                     failure: @escaping Failure) {
        request(requestType: .user, method: .get,
                success: { dictionary in
                    success(dictionary)
        }) { message in
            failure(message)
        }
    }
}
