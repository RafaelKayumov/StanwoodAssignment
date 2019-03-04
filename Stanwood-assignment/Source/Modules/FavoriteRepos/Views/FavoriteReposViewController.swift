//
//  FavoriteReposViewController.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 02/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit

class FavoriteReposViewController: ReposListViewController {}

extension FavoriteReposViewController: FavoriteReposViewInput {

    func consume(deletions: [Int], insertions: [Int], modifications: [Int]) {
        guard !collectionView.visibleCells.isEmpty else {
            collectionView.reloadData()
            return
        }

        collectionView.performBatchUpdates({
            collectionView.insertItems(at: insertions.indexPaths)
            collectionView.deleteItems(at: deletions.indexPaths)
            collectionView.reloadItems(at: modifications.indexPaths)
        }, completion: nil)
    }
}
