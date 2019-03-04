//
//  RealmQueryManager.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 03/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation
import RealmSwift

private let kDefaultSortDescriptors = [
    SortDescriptor(keyPath: "stargazersCount", ascending: false),
    SortDescriptor(keyPath: "createdAt", ascending: false)
]

protocol RealmListConsumer: class {
    associatedtype RealmObject: Object
    func consumeCompleteCollection()
    func consume(deletions: [Int], insertions: [Int], modifications: [Int])
}

class RealmQueryManager<Consumer: RealmListConsumer> {
    typealias RealmObject = Consumer.RealmObject

    private let realm: Realm
    private(set) var results: Results<RealmObject>?
    private var updatesToken: NotificationToken?
    weak var consumer: Consumer?

    var objectsCount: Int {
        return results?.count ?? 0
    }

    init(realm: Realm) {
        self.realm = realm
    }

    deinit {
        updatesToken?.invalidate()
    }

    func queryAndTrackItems(with filter: QueryFilter) {
        let query = filter.realmQueryFormatAndArguments
        let predicate = NSPredicate(format: query.format, argumentArray: query.arguments)
        results = realm.objects(RealmObject.self).filter(predicate).sorted(by: kDefaultSortDescriptors)
        registerForUpdates()
    }

    func object(at index: Int) -> RealmObject? {
        return results?[index]
    }

    private func registerForUpdates() {
        updatesToken?.invalidate()
        updatesToken = results?.observe {
            self.handleRealmChange(change: $0)
        }
    }

    private func handleRealmChange(change: RealmCollectionChange<Results<RealmObject>>) {
        switch change {
        case .initial:
            consumer?.consumeCompleteCollection()
        case .update(_, let deletions, let insertions, let modifications):
            consumer?.consume(deletions: deletions, insertions: insertions, modifications: modifications)
        case .error:
            return
        }
    }
}
