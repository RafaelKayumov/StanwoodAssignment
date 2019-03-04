//
//  AppCoordinator.swift
//
//  Created by Rafael Kayumov on 06.09.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserve
//

import UIKit

class AppCoordinator {

    private(set) static var navigationController: UINavigationController?
    private(set) static var window: UIWindow?

    static func setupUI() {
        let window = UIWindow()
        window.backgroundColor = UIColor.white

        let rootViewController = prepareRootViewController()
        let navigationController =  UINavigationController(rootViewController: rootViewController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.navigationController = navigationController
        self.window = window
    }

    private static func prepareRootViewController() -> UIViewController {
        return AppAssembly.instantiateRootTabSelector()
    }

    static func displayRepositoryDetails(for repository: Repository) {
        let moduleEntities = AppAssembly.assembleRepoDetailsModule(for: repository)
        navigationController?.pushViewController(moduleEntities.view, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            moduleEntities.module.displayRepository(repository)
        }
    }

    static func open(externalUrl: URL) {
        UIApplication.shared.open(externalUrl, options: [:], completionHandler: nil)
    }
}
