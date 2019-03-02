//
//  ReposListViewController.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit

private let kItemHeight: CGFloat = 72
private let kUpcomingItemCellIdentifier = "UpcomingItemCellIdentifier"

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
        return dataProvider.totalItemsCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let repository = dataProvider.itemForIndex(indexPath.item) {
            let cell = collectionView.dequeue(cellType: RepoCell.self, for: indexPath)
            cell.configureWithRepo(repository)
            return cell
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: kUpcomingItemCellIdentifier, for: indexPath)
        }
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
        collectionView.register(UINib(nibName: "UpcomingItemCell", bundle: nil), forCellWithReuseIdentifier: kUpcomingItemCellIdentifier)
    }

    func setupCollectionViewLayout() {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: view.bounds.width, height: kItemHeight)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
    }
}

extension ReposListViewController: ReposListViewInput {

    func reloadData() {
        reloadTableData()
    }
}

extension ReposListViewController: RepoCellDelegate {

    func repoCell(_ repoCell: RepoCell, didToggleFavoriteStateTo value: Bool) {
        
    }
}
