//
//  RepositoryRealm.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 02/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import RealmSwift

class RepositoryRealm: Object {

    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var url: String?
    @objc dynamic var repoDescription: String?
    @objc dynamic var stargazersCount = 0
    @objc dynamic var forks = 0
    @objc dynamic var createdAt: Date?
    @objc dynamic var language = ""

    @objc dynamic var owner: Owner?

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension RepositoryRealm {

    class Owner: Object {
        @objc dynamic var login = ""
        @objc dynamic var id = 0
        @objc dynamic var avatarUrl: String?

        override static func primaryKey() -> String? {
            return "id"
        }
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
            if let owner = repoToDelete.owner {
                realm.delete(owner)
            }
            realm.delete(repoToDelete)
        }
    }

    static func save(_ repository: Repository) {
        guard let realm = try? Realm() else { return }
        let repositoryRealm = RepositoryRealm(value: repository)
        try? realm.write {
            realm.add(repositoryRealm, update: true)
        }
    }
}
