//
//  Repository.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 27/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

protocol RepositoryOwner {

    var login: String { get }
    var id: Int { get }
    var avatarURL: URL? { get }
}

protocol Repository {

    var id: Int { get }
    var name: String { get }
    var url: URL? { get }
    var repoDescription: String? { get }
    var stargazersCount: Int { get }
    var forks: Int { get }
    var createdAt: Date? { get }
    var language: String? { get }

    var owner: RepositoryOwner? { get }
}

struct RepositoryPlain: Decodable {

    let id: Int
    let name: String
    let url: URL?
    let repoDescription: String?
    let stargazersCount: Int
    let forks: Int
    let createdAt: Date?
    let language: String?

    let ownerPlain: Owner?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url = "html_url"
        case repoDescription = "description"
        case stargazersCount = "stargazers_count"
        case forks
        case createdAt = "created_at"
        case language = "language"
        case ownerPlain = "owner"
    }
}

extension RepositoryPlain {

    struct Owner: Decodable, RepositoryOwner {
        let login: String
        let id: Int
        let avatarURL: URL?
    }
}

extension RepositoryPlain.Owner {

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
    }
}

extension RepositoryPlain: Repository {
    var owner: RepositoryOwner? {
        return ownerPlain
    }
}
