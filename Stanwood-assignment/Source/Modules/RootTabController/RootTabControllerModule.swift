//
//  RootTabControllerModule.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

class RootTabControllerModule: RootTabControllerViewOutput {

    func onPeriodSelection(period: ReposLoadingService.CreationPeriod) {
        AppAssembly.fetchReposModule?.applyCreationPeriod(period)
    }
}
