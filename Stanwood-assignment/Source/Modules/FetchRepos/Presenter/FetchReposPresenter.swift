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
}

// MARK: Data loading

private extension FetchReposPresenter {

    enum ReposListBatchLoadingOption {
        case initial(Repository.CreationPeriod)
        case next(URL)
    }

    typealias RepositoryListLoadCompletion = ([Repository]?, URL?) -> Void

    func loadReposListBatch() {
        var option: ReposListBatchLoadingOption
        if let nextPageURL = repositoryList.nextPageURL {
            option = .next(nextPageURL)
        } else {
            option = .initial(.day)
        }

        loadReposListBatch(with: option) { repos, nextPageURL in
            guard let validRepos = repos else { return }

            DispatchQueue.main.async {
                self.repositoryList.applyReposBatch(validRepos, nextPageURL: nextPageURL)
                self.populateView()
            }
        }
    }

    func loadReposListBatch(with option: ReposListBatchLoadingOption, completion: @escaping RepositoryListLoadCompletion) {
        let loadingCompletion: ReposLoadingService.ReposFetchingCompletion = { repos, nextPageURL, _ in
            completion(repos, nextPageURL)
        }
        switch option {
        case .initial(let period):
            reposLoadingService.fetchMostTrendingForPeriod(period, completion: loadingCompletion)
        case .next(let url):
            reposLoadingService.fetch(with: url, completion: loadingCompletion)
        }
    }
}

// MARK: Data provider

extension FetchReposPresenter: FetchReposViewDataProvider {
    func repoForIndex(_ index: Int) -> Repository? {
        return repositoryList[index]
    }

    var reposCount: Int {
        return repositoryList.count
    }
}

// MARK: View output handling

extension FetchReposPresenter: FetchReposViewOutput {

    func onViewReady() {
        loadReposListBatch()
    }

    func onCellSelectAtIndex(_ index: Int) {

    }
}

extension FetchReposPresenter: FetchReposModuleInput {

    func applyCreationPeriod(_ creationPeriod: Repository.CreationPeriod) {
        print("")
    }
}
