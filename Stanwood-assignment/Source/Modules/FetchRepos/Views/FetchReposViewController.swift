//
//  FetchReposViewController.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit

class FetchReposViewController: ReposListViewController {

    private weak var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        applyRefreshControl()
    }
}

private extension FetchReposViewController {

    // MARK: Methods

    func applyRefreshControl() {
        self.refreshControl =  collectionView.setRefreshControl(self, with: #selector(onPullToRefresh))
    }

    func refreshData() {

    }

    // MARK: Actions

    @objc func onPullToRefresh() {
        refreshData()
    }
}

extension FetchReposViewController: FetchReposViewInput {
}
