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
}

class RepositoryOwnerRealm: Object {
    @objc dynamic var login = ""
    @objc dynamic var id = 0
    @objc dynamic var avatarURLString: String?

    override static func primaryKey() -> String? {
        return "id"
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
            realm.create(RepositoryRealm.self, value: ["id": 123123, "name": "test"], update: true)
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
