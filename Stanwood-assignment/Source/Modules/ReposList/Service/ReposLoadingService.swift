//
//  ReposLoadingService.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 27/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

class ReposLoadingService {

    typealias ReposFetchingCompletion = ([RepositoryPlain]?, Int?, URL?, Error?) -> Void

    private let transport: NetworkingTransport
    private var dataTask: URLSessionDataTask?
    init(transport: NetworkingTransport = NetworkingTransport()) {
        self.transport = transport
    }

    private func reposResponseDataHandler(with completion: @escaping ReposFetchingCompletion) -> NetworkingTransport.DataTaskCompletion {
        return { data, urlResponse, error in
            guard error == nil,
                let data = data else {
                    completion(nil, nil, nil, error)
                    return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let reposPayload = try? decoder.decode(RepositorySearchPayload.self, from: data)

            let nextPageURL = urlResponse?.nextPageURL

            completion(reposPayload?.items, reposPayload?.totalCount, nextPageURL, nil)
        }
    }

    func fetchMostTrendingForPeriod(_ period: RepositoryPlain.CreationPeriod, completion: @escaping ReposFetchingCompletion) {
        dataTask = transport.query(Route.list(creationPeriod: period), with: reposResponseDataHandler(with: completion))
    }

    func fetch(with url: URL, completion: @escaping ReposFetchingCompletion) {
        dataTask = transport.fetchDataWithURL(url, completion: reposResponseDataHandler(with: completion))
    }

    func cancelTask() {
        dataTask?.cancel()
        dataTask = nil
    }
}

private let kBaseURLString = "api.github.com"
private let kSearchReposPath = "/search/repositories"

private let kDefaultQueryParams = [
    "sort": "stars",
    "order": "desc"
]

extension ReposLoadingService {

    enum Route: RouteProviding {
        case list(creationPeriod: RepositoryPlain.CreationPeriod)

        var path: String {
            switch self {
            case .list:
                return kSearchReposPath
            }
        }

        var host: String {
            switch self {
            case .list:
                return kBaseURLString
            }
        }

        var queryParams: [String: String] {
            switch self {
            case .list(let period):
                let periodQueryParams = ["q": period.queryValue]
                return periodQueryParams.merging(kDefaultQueryParams) { (_, new) in new }
            }
        }
    }
}
