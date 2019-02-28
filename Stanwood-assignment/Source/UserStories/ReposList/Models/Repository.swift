//
//  Repository.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 27/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

struct Repository: Decodable {

    let id: Int
    let name: String
    let url: URL?
    let description: String
    let stargazersCount: Int
    let forks: Int
    let createdAt: Date
    let language: String?

    let owner: Owner

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url = "html_url"
        case description
        case stargazersCount = "stargazers_count"
        case forks
        case createdAt = "created_at"
        case language = "language"
        case owner
    }
}

extension Repository {

    struct Owner: Decodable {

        let login: String
        let id: Int
        let avatarURL: URL?
    }
}

extension Repository.Owner {

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
    }
}
