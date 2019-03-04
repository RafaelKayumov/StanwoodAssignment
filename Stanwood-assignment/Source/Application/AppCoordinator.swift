//
//  AppCoordinator.swift
//
//  Created by Rafael Kayumov on 06.09.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserve
//

import UIKit

class AppCoordinator {

    static let shared = AppCoordinator()

    private(set) var navigationController: UINavigationController?
    private(set) var splitViewController: UISplitViewController?
    private(set) var detailsViewController: RepoDetailsViewController?
    private(set) var window: UIWindow?

    func setupUI() {
        let window = UIWindow()
        window.backgroundColor = UIColor.white

        let rootViewController = prepareRootViewController()
        let navigationController =  UINavigationController(rootViewController: rootViewController)
        let splitViewController = UISplitViewController()
        let detailsViewController = AppAssembly.instantiateRepoDetailsModuleAndReturnView()

        splitViewController.viewControllers = [navigationController, detailsViewController]
        splitViewController.delegate = self

        window.rootViewController = splitViewController
        window.makeKeyAndVisible()

        self.navigationController = navigationController
        self.splitViewController = splitViewController
        self.detailsViewController = detailsViewController
        self.window = window
    }

    private func prepareRootViewController() -> UIViewController {
        return AppAssembly.instantiateRootTabSelector()
    }

    func displayRepositoryDetails(for repository: Repository) {
        AppAssembly.repoDetailsModule?.displayRepository(repository)
        guard let detailsViewController = detailsViewController else { return }
        splitViewController?.showDetailViewController(detailsViewController, sender: nil)
    }

    func open(externalUrl: URL) {
        UIApplication.shared.open(externalUrl, options: [:], completionHandler: nil)
    }
}

extension AppCoordinator: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
