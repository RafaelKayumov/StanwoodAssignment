//
//  NetworkingTransport.swift
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import Foundation

//hardcoded in scope of test task
//Normally should be acquired during authorization and stored in keychain
private let kAuthToken = ""

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

    func query(_ route: RouteProviding, with completion: @escaping DataTaskCompletion) -> URLSessionDataTask {
        return fetchDataWithURL(route.url, completion: completion)
    }

    func fetchDataWithURL(_ url: URL, completion: @escaping DataTaskCompletion) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if kAuthToken.isEmpty == false {
            request.addValue("token \(kAuthToken)", forHTTPHeaderField: "Authorization")
        }

        return performRequest(request, with: completion)
    }
}

private extension NetworkingTransport {

    func performRequest(_ request: URLRequest, with completion: @escaping DataTaskCompletion) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }

        task.resume()

        return task
    }
}
