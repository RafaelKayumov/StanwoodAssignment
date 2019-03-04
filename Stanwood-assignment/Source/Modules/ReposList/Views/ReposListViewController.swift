//
//  ReposListViewController.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit

private let kItemHeight: CGFloat = 72
private let kNoResultsHeaderHeight: CGFloat = 50
private let kUpcomingItemCellIdentifier = "UpcomingItemCellIdentifier"

class ReposListViewController: UICollectionViewController {

    weak var dataProvider: ReposListViewDataProvider!
    weak var output: ReposListViewOutput!

    private var collectionViewFlowLayout: UICollectionViewFlowLayout? {
        return collectionViewLayout as? UICollectionViewFlowLayout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alwaysBounceVertical = true

        registerCells()
        setupCollectionViewLayout()

        output.onViewReady()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateItemSize()
    }
}

extension ReposListViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.totalItemsCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let repository = dataProvider.itemForIndex(indexPath.item) {
            let cell = collectionView.dequeue(cellType: RepoCell.self, for: indexPath)
            let persisted = dataProvider.itemIsPersistedForIndex(indexPath.item)
            cell.configureWithRepo(repository, favorite: persisted)
            cell.delegate = self
            return cell
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: kUpcomingItemCellIdentifier, for: indexPath)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueHeader(cellType: NoResultsView.self, for: indexPath)

        return headerView
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        output.onCellSelectAtIndex(indexPath.item)
    }
}

private extension ReposListViewController {

    func reloadTableData() {
        collectionView.reloadData()
    }

    func registerCells() {
        collectionView.register(cellType: RepoCell.self)
        collectionView.register(UINib(nibName: "UpcomingItemCell", bundle: nil), forCellWithReuseIdentifier: kUpcomingItemCellIdentifier)
        collectionView.register(UINib(nibName: "NoResultsView", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: String(describing: NoResultsView.self))
    }

    func setupCollectionViewLayout() {
        guard let flowLayout = collectionViewFlowLayout else { return }
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        updateItemSize()
    }

    func updateItemSize() {
        collectionViewFlowLayout?.itemSize = CGSize(width: view.bounds.width, height: kItemHeight)
    }
}

extension ReposListViewController: ReposListViewInput {

    func setNoResultsStatusDisplayed(_ displayed: Bool) {
        guard let flowLayout = collectionViewFlowLayout else { return }
        let height: CGFloat = displayed ? kNoResultsHeaderHeight : 0
        flowLayout.headerReferenceSize = CGSize(width: self.collectionView.frame.size.width, height: height)
    }

    func reloadData() {
        reloadTableData()
    }
}

extension ReposListViewController: RepoCellDelegate {

    func repoCell(_ repoCell: RepoCell, didToggleFavoriteStateTo value: Bool) {
        guard let index = collectionView.indexPath(for: repoCell)?.item else { return }
        output.repoCell(at: index, didToggleFavoriteStateTo: value)
    }
}
