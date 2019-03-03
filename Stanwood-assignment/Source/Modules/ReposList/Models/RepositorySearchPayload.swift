//
//  RepositorySearchPayload.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 27/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

struct RepositorySearchPayload: Decodable {

    let totalCount: Int
    let incompleteResults: Bool
    let items: [RepositoryPlain]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
