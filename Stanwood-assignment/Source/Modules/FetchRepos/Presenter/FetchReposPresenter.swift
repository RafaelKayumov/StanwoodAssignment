//
//  FetchReposPresenter.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

class FetchReposPresenter {

    private let reposLoadingService: ReposLoadingService
    private unowned var view: FetchReposViewInput
    private var repositoryList = RepositoryList()

    private var queryFilter = QueryFilter()
    private var isLoadingInProgress = false

    init(reposLoadingService: ReposLoadingService, view: FetchReposViewInput) {
        self.reposLoadingService = reposLoadingService
        self.view = view
    }
}

// MARK: Methods

private extension FetchReposPresenter {

    func populateView() {
        view.reloadData()
    }

    func reloadUpcomingViewContent() {
        view.reloadVisibleCells()
    }

    func handeFavoriteStatusForRepo(at index: Int, favorite: Bool) {
        guard let repo = repositoryList[index] else { return }
        RealmWritesManager.writeAsync {
            if favorite {
                RepositoryRealm.save(repo)
            } else {
                RepositoryRealm.delete(with: repo.id)
            }
        }
    }
}

// MARK: Data loading

private extension FetchReposPresenter {

    enum ReposListBatchLoadingOption {
        case initial(RepositoryPlain.CreationPeriod)
        case next(URL)
    }

    typealias RepositoryListLoadCompletion = ([RepositoryPlain]?, Int?, URL?) -> Void

    func loadReposListBatch() {
        var option: ReposListBatchLoadingOption
        var displayFunction: () -> Void
        if let nextPageURL = repositoryList.nextPageURL {
            option = .next(nextPageURL)
            displayFunction = reloadUpcomingViewContent
        } else {
            option = .initial(queryFilter.creationPeriod)
            displayFunction = populateView
        }

        loadReposListBatch(with: option) { repos, totalExisting, nextPageURL in
            guard let validRepos = repos else { return }

            DispatchQueue.main.async {
                self.repositoryList.applyReposBatch(validRepos, nextPageURL: nextPageURL)
                if case .initial = option, let totalExistingValid = totalExisting {
                    self.repositoryList.totalExisting = totalExistingValid
                }
                displayFunction()
            }
        }
    }

    func loadReposListBatch(with option: ReposListBatchLoadingOption, completion: @escaping RepositoryListLoadCompletion) {
        let loadingCompletion: ReposLoadingService.ReposFetchingCompletion = { repos, totalExisting, nextPageURL, _ in
            self.isLoadingInProgress = false
            completion(repos, totalExisting, nextPageURL)
        }

        isLoadingInProgress = true
        switch option {
        case .initial(let period):
            reposLoadingService.fetchMostTrendingForPeriod(period, completion: loadingCompletion)
        case .next(let url):
            reposLoadingService.fetch(with: url, completion: loadingCompletion)
        }
    }

    func cancelTasksAndClearRepos() {
        reposLoadingService.cancelTask()
        isLoadingInProgress = false
        repositoryList.clear()
        populateView()
    }
}

// MARK: Prefetch calculations

private extension FetchReposPresenter {

    func triggerNextBatchLoadIfNeeded(triggeredCellIndexes: [Int]) {
        guard
            !isLoadingInProgress,
            repositoryList.nextPageURL != nil,
            !repositoryList.allLoaded,
            let lastIndex = triggeredCellIndexes.last,
            repositoryList[lastIndex] == nil
        else {
            return
        }

        loadReposListBatch()
    }
}

// MARK: Data provider

extension FetchReposPresenter: ReposListViewDataProvider {
    func itemForIndex(_ index: Int) -> Repository? {
        return repositoryList[index]
    }

    var totalItemsCount: Int {
        return repositoryList.totalExisting
    }
}

// MARK: Prefetching output handling

extension FetchReposPresenter: PrefetchingOutput {

    func didTriggerPrefetch(at indexes: [Int]) {
        triggerNextBatchLoadIfNeeded(triggeredCellIndexes: indexes)
    }
}

// MARK: View output handling

extension FetchReposPresenter: FetchReposViewOutput {

    func onViewReady() {
        loadReposListBatch()
        AppAssembly.rootTabbarControllerModule?.selectPeriod(queryFilter.creationPeriod)
    }

    func onCellSelectAtIndex(_ index: Int) {

    }

    func repoCell(at index: Int, didToggleFavoriteStateTo value: Bool) {
        handeFavoriteStatusForRepo(at: index, favorite: value)
    }
}

extension FetchReposPresenter: FetchReposModuleInput {

    func applyCreationPeriod(_ creationPeriod: RepositoryPlain.CreationPeriod) {
        cancelTasksAndClearRepos()
        queryFilter.creationPeriod = creationPeriod
        loadReposListBatch()
    }
}
