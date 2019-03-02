//
//  NetworkingTransport.swift
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import Foundation

//haradcoded in scope of test task
//Normally should be acquired during authorization and stored in keychain
private let kAuthToken = "3fb98bb8ebde8c5bfd0e72af752c468b70048129"

private let kURLScheme = "https"

protocol RouteProviding {
    var host: String { get }
    var path: String { get }
    var queryParams: [String: String] { get }

    var url: URL { get }
}

extension RouteProviding {
    var url: URL {
        var components = URLComponents()
        components.scheme = kURLScheme
        components.host = host
        components.path = path
        components.queryItems = queryParams.compactMap {
            return URLQueryItem(name: $0.key, value: $0.value)
        }
        return components.url!
    }
}

class NetworkingTransport {

    typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void

    let session: URLSession
    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }

    func query(_ route: RouteProviding, with completion: @escaping DataTaskCompletion) {
        var request = URLRequest(url: route.url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("token \(kAuthToken)", forHTTPHeaderField: "Authorization")

        performRequest(request, with: completion)
    }

    func fetchDataWithURL(_ url: URL, completion: @escaping DataTaskCompletion) {
        performRequest(URLRequest(url: url), with: completion)
    }
}

private extension NetworkingTransport {

    func performRequest(_ request: URLRequest, with completion: @escaping DataTaskCompletion) {
        let task = session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }

        task.resume()
    }
}
