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
        super.viewDidLoad()
        collectionView.prefetchDataSource = self
    }
}

extension FetchReposViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        prefetchingOutput.didTriggerPrefetch(at: indexPaths.map { $0.item })
    }
}

private extension FetchReposViewController {

    // MARK: Methods

    // MARK: Actions
}

extension FetchReposViewController: FetchReposViewInput {
    func reloadVisibleCells() {
        let visibleCellsIndexes = collectionView.indexPathsForVisibleItems
        if !visibleCellsIndexes.isEmpty {
            collectionView.reloadItems(at: visibleCellsIndexes)
        } else {
            collectionView.reloadData()
        }
    }
}
