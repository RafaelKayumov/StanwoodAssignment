//
//  NetworkingTransport.swift
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import Foundation

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
        request.setValue("application/json", forHTTPHeaderField: "Accept")

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
