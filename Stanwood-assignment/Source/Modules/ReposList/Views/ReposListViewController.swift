//
//  ReposListViewController.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit

private let kItemHeight: CGFloat = 50

class ReposListViewController: UICollectionViewController {

    weak var dataProvider: ReposListViewDataProvider!
    weak var output: ReposListViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        setupCollectionViewLayout()

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

    func setupCollectionViewLayout() {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: view.bounds.width, height: kItemHeight)
    }
}

extension ReposListViewController: ReposListViewInput {

    func reloadData() {
        reloadTableData()
    }
}
