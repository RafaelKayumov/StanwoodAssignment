//
//  RepositoryDetailsPresenter.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 04/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

class RepositoryDetailsPresenter {

    private unowned var view: RepoDetailsViewInput
    private var repositoryURL: URL?

    init(view: RepoDetailsViewInput) {
        self.view = view
    }
}

extension RepositoryDetailsPresenter: RepositoryDetailsModuleInput {

    func displayRepository(_ repository: Repository) {
        repositoryURL = repository.url
        view.displayRepository(repository)
    }
}

extension RepositoryDetailsPresenter: RepoDetailsViewOutput {

    func onOpenOnGithub() {
        guard let repositoryURL = repositoryURL else { return }
        AppCoordinator.open(externalUrl: repositoryURL)
    }
}
