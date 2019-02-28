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
}
