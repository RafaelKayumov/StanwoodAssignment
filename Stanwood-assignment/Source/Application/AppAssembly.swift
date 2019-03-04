//
//  AppAssembly.swift
//  AbihomeTestTask
//
//  Created by Rafael Kayumov on 08.10.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit
import RealmSwift

class AppAssembly {

    private(set) static var rootTabbarControllerModule: RootTabControllerModule?
    private(set) static var fetchReposModule: FetchReposModuleInput?
    private(set) static var favoriteReposModule: FavoriteReposModuleInput?
    private(set) static var repoDetailsModule: RepositoryDetailsModuleInput?

    static func instantiateFetchReposModuleAndReturnView() -> UIViewController {
        let fetchReposModuleEntities = assembleFetchReposModule()
        fetchReposModule = fetchReposModuleEntities.module
        return fetchReposModuleEntities.view
    }

    static func instantiateFavoritesReposModuleAndReturnView() -> UIViewController {
        let favoriteReposModuleEntities = assembleFavoriteReposModule()
        favoriteReposModule = favoriteReposModuleEntities.module
        return favoriteReposModuleEntities.view
    }

    static func instantiateRepoDetailsModuleAndReturnView() -> RepoDetailsViewController {
        let repoDetailsModuleEntities = assembleRepoDetailsModule()
        repoDetailsModule = repoDetailsModuleEntities.module
        return repoDetailsModuleEntities.view
    }

    static func instantiateRootTabSelector() -> UITabBarController {
        let rootTabbarControllerEntities = assembleRootTabController()
        rootTabbarControllerModule = rootTabbarControllerEntities.module
        let rootTabbarController = rootTabbarControllerEntities.view

        let reposListView = instantiateFetchReposModuleAndReturnView()
        let favoriteReposView = instantiateFavoritesReposModuleAndReturnView()
        rootTabbarController.viewControllers = [reposListView, favoriteReposView]
        return rootTabbarController
    }

    static func assembleRepoDetailsModule() -> (module: RepositoryDetailsModuleInput, view: RepoDetailsViewController) {
        let repoDetailsView = UIStoryboard(name: String(describing: RepoDetailsViewController.self), bundle: nil).instantiate(viewController: RepoDetailsViewController.self)
        let repoDetailsPresenter = RepositoryDetailsPresenter(view: repoDetailsView)
        repoDetailsView.output = repoDetailsPresenter

        return (module: repoDetailsPresenter, view: repoDetailsView)
    }
}

private extension AppAssembly {

    static func assembleFetchReposModule() -> (module: FetchReposModuleInput, view: UIViewController) {
        let fetchReposView = FetchReposViewController(collectionViewLayout: UICollectionViewFlowLayout())
        fetchReposView.title = "Repositories"
        let reposLoadingService = ReposLoadingService()
        let fetchReposPresenter = FetchReposPresenter(reposLoadingService: reposLoadingService, view: fetchReposView)
        fetchReposView.output = fetchReposPresenter
        fetchReposView.prefetchingOutput = fetchReposPresenter
        fetchReposView.dataProvider = fetchReposPresenter
        fetchReposView.applyDefaultSettings()

        return (module: fetchReposPresenter, view: fetchReposView)
    }

    static func assembleFavoriteReposModule() -> (module: FavoriteReposModuleInput, view: UIViewController) {
        let favoriteReposView = FavoriteReposViewController(collectionViewLayout: UICollectionViewFlowLayout())
        favoriteReposView.title = "Favorites"
        let repositoriesRealmQueryManager = RealmQueryManager<FavoriteReposPresenter>(realm: (try? Realm())!)
        let favoriteReposPresenter = FavoriteReposPresenter(realmQueryManager: repositoriesRealmQueryManager, view: favoriteReposView)
        repositoriesRealmQueryManager.consumer = favoriteReposPresenter
        favoriteReposView.output = favoriteReposPresenter
        favoriteReposView.dataProvider = favoriteReposPresenter
        favoriteReposView.applyDefaultSettings()

        return (module: favoriteReposPresenter, view: favoriteReposView)
    }

    static func assembleRootTabController() -> (module: RootTabControllerModule, view: UITabBarController) {
        let tabbarController = RootTabbarController()
        let rootTabControllerModule = RootTabControllerModule(view: tabbarController)
        tabbarController.output = rootTabControllerModule

        return (module: rootTabControllerModule, view: tabbarController)
    }
}
