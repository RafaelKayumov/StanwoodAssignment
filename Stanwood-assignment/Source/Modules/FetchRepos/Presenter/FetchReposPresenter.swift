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

    init(reposLoadingService: ReposLoadingService, view: FetchReposViewInput) {
        self.reposLoadingService = reposLoadingService
        self.view = view
    }
}

private extension FetchReposPresenter {
}

extension FetchReposPresenter: FetchReposViewDataProvider {
    func repoForIndex(_ index: Int) -> Repository? {
        return nil
    }

    var reposCount: Int {
        return 0
    }
}

extension FetchReposPresenter: FetchReposViewOutput {

    func onViewReady() {

    }

    func onCellSelectAtIndex(_ index: Int) {

    }
}

extension FetchReposPresenter: FetchReposModuleInput {}
