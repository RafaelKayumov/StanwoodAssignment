//
//  ReposLoadingService.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 27/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

class ReposLoadingService {

    typealias ReposFetchingCompletion = ([Repository]?, URL?, Error?) -> Void

    private let transport: NetworkingTransport
    init(transport: NetworkingTransport = NetworkingTransport()) {
        self.transport = transport
    }

    private func reposResponseDataHandler(with completion: @escaping ReposFetchingCompletion) -> NetworkingTransport.DataTaskCompletion {
        return { data, urlResponse, error in
            guard error == nil,
                let data = data else {
                    completion(nil, nil, error)
                    return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let reposPayload = try? decoder.decode(RepositorySearchPayload.self, from: data)

            let nextPageURL = urlResponse?.nextPageURL

            completion(reposPayload?.items, nextPageURL, nil)
        }
    }

    func fetchMostTrendingForPeriod(_ period: Repository.CreationPeriod, completion: @escaping ReposFetchingCompletion) {
        transport.query(Route.list(creationPeriod: period), with: reposResponseDataHandler(with: completion))
    }

    func fetch(with url: URL, completion: @escaping ReposFetchingCompletion) {
        transport.fetchDataWithURL(url, completion: reposResponseDataHandler(with: completion))
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
        case list(creationPeriod: Repository.CreationPeriod)

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

extension Repository.CreationPeriod {

    var calendarInterval: Calendar.Component {
        switch self {
        case .day:
            return Calendar.Component.day
        case .month:
            return Calendar.Component.month
        case .year:
            return Calendar.Component.year
        }
    }

    var thresholdDate: Date {
        return Calendar.current.date(byAdding: calendarInterval, value: -1, to: Date())!
    }

    var queryValue: String {
        let dateString = ISO8601DateFormatter().string(from: thresholdDate)
        return "created:>" + dateString
    }
}
