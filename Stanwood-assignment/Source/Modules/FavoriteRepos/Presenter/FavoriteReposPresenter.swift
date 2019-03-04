//
//  FavoriteReposPresenter.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 02/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

class FavoriteReposPresenter {

    private unowned var view: FavoriteReposViewInput
    private var queryFilter = QueryFilter()
    private var realmQueryManager: RealmQueryManager<FavoriteReposPresenter>

    init(realmQueryManager: RealmQueryManager<FavoriteReposPresenter>, view: FavoriteReposViewInput) {
        self.realmQueryManager = realmQueryManager
        self.view = view
    }
}

private extension FavoriteReposPresenter {
    func displayCollectionForCurrentFilter() {
        realmQueryManager.queryAndTrackItems(with: queryFilter)
    }
}

extension FavoriteReposPresenter: FavoriteReposViewOutput {

    func onViewReady() {
        displayCollectionForCurrentFilter()
    }

    func onCellSelectAtIndex(_ index: Int) {
    }

    func repoCell(at index: Int, didToggleFavoriteStateTo value: Bool) {
    }
}

extension FavoriteReposPresenter: RealmListConsumer {
    typealias RealmObject = RepositoryRealm

    func consumeCompleteCollection() {
        view.reloadData()
    }

    func consume(deletions: [Int], insertions: [Int], modifications: [Int]) {
    }
}

extension FavoriteReposPresenter: ReposListViewDataProvider {
    func itemIsPersistedForIndex(_ index: Int) -> Bool {
        return true
    }

    func itemForIndex(_ index: Int) -> Repository? {
        return realmQueryManager.object(at: index)
    }

    var totalItemsCount: Int {
        return realmQueryManager.objectsCount
    }
}

extension FavoriteReposPresenter: FavoriteReposModuleInput {

    func applyCreationPeriod(_ creationPeriod: RepositoryPlain.CreationPeriod) {
        queryFilter.creationPeriod = creationPeriod
        displayCollectionForCurrentFilter()
    }
}
