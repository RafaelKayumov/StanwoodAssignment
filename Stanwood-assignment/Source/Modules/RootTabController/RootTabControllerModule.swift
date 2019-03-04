//
//  RootTabControllerModule.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

class RootTabControllerModule: RootTabControllerViewOutput {

    private weak var view: RootTabControllerViewInput!

    init(view: RootTabControllerViewInput) {
        self.view = view
    }

    func onPeriodSelection(period: RepositoryPlain.CreationPeriod) {
        AppAssembly.fetchReposModule?.applyCreationPeriod(period)
        AppAssembly.favoriteReposModule?.applyCreationPeriod(period)
    }
}

extension RootTabControllerModule: RootTabControllerModuleInput {

    func selectPeriod(_ period: RepositoryPlain.CreationPeriod) {
        view.selectPeriod(period)
    }
}
