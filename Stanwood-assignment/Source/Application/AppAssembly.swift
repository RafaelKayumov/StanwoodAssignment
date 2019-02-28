//
//  AppAssembly.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

class AppAssembly {

    private(set) static var fetchReposModule: FetchReposModuleInput?

    static func instantiateFetchReposModuleAndReturnView() -> UIViewController {
        let fetchReposModuleEntities = assembleFetchReposModule()
        fetchReposModule = fetchReposModuleEntities.module
        return fetchReposModuleEntities.view
    }

    static func instantiateFavoritesReposModuleAndReturnView() -> UIViewController {
        return UIViewController()
    }

    static func instantiateRootTabSelector() -> UITabBarController {
        let rootTabbarController = UITabBarController()
        let reposListView = instantiateFetchReposModuleAndReturnView()
        //let favoriteReposView = instantiateFavoritesReposModuleAndReturnView()
        rootTabbarController.viewControllers = [reposListView]
        return rootTabbarController
    }
}

private extension AppAssembly {

    static func assembleFetchReposModule() -> (module: FetchReposModuleInput, view: UIViewController) {
        let fetchReposView = FetchReposViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let reposLoadingService = ReposLoadingService()
        let fetchReposPresenter = FetchReposPresenter(reposLoadingService: reposLoadingService, view: fetchReposView)
        fetchReposView.output = fetchReposPresenter
        fetchReposView.dataProvider = fetchReposPresenter
        fetchReposView.applyDefaultSettings()

        return (module: fetchReposPresenter, view: fetchReposView)
    }
}