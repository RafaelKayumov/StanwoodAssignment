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
                let data = data else {
                    completion(nil, error)
                    return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let reposPayload = try? decoder.decode(RepositorySearchPayload.self, from: data)

            completion(reposPayload?.items, nil)
        }
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
                return periodQueryParams.merging(kDefaultQueryParams) { (_, new) in new }
            }
        }
    }

    enum CreationPeriod: Int {
        case day
        case week
        case month

        var calendarInterval: Calendar.Component {
            switch self {
            case .day:
                return Calendar.Component.day
            case .week:
                return Calendar.Component.weekOfMonth
            case .month:
                return Calendar.Component.month
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
}
