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

    typealias RepositoryListLoadCompletion = ([Repository]?) -> Void

    func loadReposListHead() {
        loadReposListHeadWithCompletion {
            guard let validRepos = $0 else { return }

            DispatchQueue.main.async {
                self.repositoryList.applyRepos(validRepos)
                self.populateView()
            }
        }
    }

    func loadReposListHeadWithCompletion(_ completion: @escaping RepositoryListLoadCompletion) {
        reposLoadingService.fetchMostTrendingForPeriod(.day) { repos, _ in
            completion(repos)
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
        loadReposListHead()
    }

    func onCellSelectAtIndex(_ index: Int) {

    }
}

extension FetchReposPresenter: FetchReposModuleInput {

    func applyCreationPeriod(_ creationPeriod: ReposLoadingService.CreationPeriod) {
        print("")
    }
}
