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
    weak var prefetchingOutput: PrefetchingOutput!

    override func viewDidLoad() {
        stupRefreshControl()
        tabBarItem.image = UIImage(named: "octoface")

        super.viewDidLoad()
        collectionView.prefetchDataSource = self
    }
}

private extension FetchReposViewController {

    func stupRefreshControl() {
        refreshControl = collectionView.setRefreshControl(self, with: #selector(onRefreshControl), tintColor: UIColor.darkGray)
        collectionView.alwaysBounceVertical = true
    }

    @objc func onRefreshControl() {
        (output as? FetchReposViewOutput)?.didTriggerRefresh()
    }
}

extension FetchReposViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        prefetchingOutput.didTriggerPrefetch(at: indexPaths.map { $0.item })
    }
}

extension FetchReposViewController: FetchReposViewInput {

    func reloadCell(at index: Int) {
        collectionView.performBatchUpdates({
            self.collectionView.reloadItems(at: [index.indexPath])
        }, completion: nil)
    }

    func reloadVisibleCells() {
        let visibleCellsIndexes = collectionView.indexPathsForVisibleItems
        if !visibleCellsIndexes.isEmpty {
            collectionView.performBatchUpdates({
                self.collectionView.reloadItems(at: visibleCellsIndexes)
            }, completion: nil)
        } else {
            collectionView.reloadData()
        }
    }

    func displayLoadingInProgress(_ inProgress: Bool) {
        if inProgress {
            refreshControl.beginRefreshing()
        } else {
            refreshControl.endRefreshing()
        }
    }
}
