//
//  ReposLoadingService.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 27/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

class ReposLoadingService {

    typealias ReposFetchingCompletion = ([Repository]?, Error?) -> Void

    private let transport: NetworkingTransport
    init(transport: NetworkingTransport = NetworkingTransport()) {
        self.transport = transport
    }

    func fetchMostTrendingForPeriod(_ period: CreationPeriod, completion: @escaping ReposFetchingCompletion) {
        transport.query(Route.list(creationPeriod: period)) { data, _, error in
            guard error == nil,
                let data = data,
                let reposPayload = try? JSONDecoder().decode(RepositorySearchPayload.self, from: data) else {
                    completion(nil, error)
                    return
            }

            completion(reposPayload.items, nil)
        }
    }
}

private let kBaseURLString = "http://api.github.com/"
private let kSearchReposPath = "search/repositories/"

private let kDefaultQueryParams = [
    "sort": "stars",
    "order": "desc"
]

extension ReposLoadingService {

    enum Route: RouteProviding {
        case list(creationPeriod: CreationPeriod)

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
                return kDefaultQueryParams.merging(periodQueryParams) { (_, new) in new }
            }
        }
    }

    enum CreationPeriod: String {
        case day = "d"
        case week = "w"
        case month = "m"

        var queryValue: String {
            return "created:>`date -v-1\(rawValue) '+%Y-%m-%d'`"
        }
    }
}
