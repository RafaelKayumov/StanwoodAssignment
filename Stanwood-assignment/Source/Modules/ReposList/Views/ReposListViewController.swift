//
//  ReposListViewController.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit

class ReposListViewController: UICollectionViewController {

    weak var dataProvider: ReposListViewDataProvider!
    weak var output: ReposListViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()

        output.onViewReady()
    }
}

extension ReposListViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.reposCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellType: RepoCell.self, for: indexPath)
        if let repository = dataProvider.repoForIndex(indexPath.item) {
            cell.configureWithRepo(repository)
        }
        return cell
    }
}

extension ReposListViewController {

     // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     }
}

private extension ReposListViewController {
    func reloadTableData() {
        collectionView.reloadData()
    }

    func registerCells() {
        collectionView.register(cellType: RepoCell.self)
    }
}

extension ReposListViewController: ReposListViewInput {

    func reloadData() {
        reloadTableData()
    }
}
