//
//  RepositoryRealm.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 02/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import RealmSwift

class RepositoryRealm: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var name = ""
    @objc dynamic var urlString: String?
    @objc dynamic var repoDescription: String?
    @objc dynamic var stargazersCount = 0
    @objc dynamic var forks = 0
    @objc dynamic var createdAt: Date?
    @objc dynamic var language: String?

    @objc dynamic var repoOwner: RepositoryOwnerRealm?

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(repositoryPlain: RepositoryPlain) {
        self.init()
        id = repositoryPlain.id
        name = repositoryPlain.name
        urlString = repositoryPlain.url?.absoluteString
        repoDescription = repositoryPlain.repoDescription
        stargazersCount = repositoryPlain.stargazersCount
        forks = repositoryPlain.forks
        createdAt = repositoryPlain.createdAt
        language = repositoryPlain.language

        if let owner = repositoryPlain.ownerPlain {
            repoOwner = RepositoryOwnerRealm(repositoryOwnerPlain: owner)
        }
    }

    static func containsObject(with id: Int) -> Bool {
        guard let realm = try? Realm() else { return false }
        return realm.object(ofType: self, forPrimaryKey: id) != nil
    }
}

class RepositoryOwnerRealm: Object {
    @objc dynamic var login = ""
    @objc dynamic var id = 0
    @objc dynamic var avatarURLString: String?

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(repositoryOwnerPlain: RepositoryPlain.Owner) {
        self.init()
        login = repositoryOwnerPlain.login
        id = repositoryOwnerPlain.id
        avatarURLString = repositoryOwnerPlain.avatarURL?.absoluteString
    }
}

extension RepositoryRealm {

    static func delete(with id: Int) {
        guard
            let realm = try? Realm(),
            let repoToDelete = realm.object(ofType: self, forPrimaryKey: id)
        else {
            return
        }

        try? realm.write {
            if let owner = repoToDelete.repoOwner {
                realm.delete(owner)
            }
            realm.delete(repoToDelete)
        }
    }

    static func save(_ repository: RepositoryPlain) {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            let repositoryRealm = RepositoryRealm(repositoryPlain: repository)
            realm.add(repositoryRealm, update: true)
        }
    }
}

extension RepositoryOwnerRealm: RepositoryOwner {
    var avatarURL: URL? {
        guard let avatarURLString = avatarURLString, let url = URL(string: avatarURLString) else { return nil }
        return url
    }
}

extension RepositoryRealm: Repository {
    var owner: RepositoryOwner? {
        return repoOwner
    }

    var url: URL? {
        guard let urlString = urlString, let url = URL(string: urlString) else { return nil }
        return url
    }
}
