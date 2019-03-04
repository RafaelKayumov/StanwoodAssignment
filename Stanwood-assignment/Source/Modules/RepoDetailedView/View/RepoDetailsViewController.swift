//
//  RepoDetailsViewController.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 04/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit

enum RepositoryProperty {
    case languages([String])
    case forks(Int)
    case stars(Int)
    case creationDate(Date)
}

class RepoDetilsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var openRepoButton: UIButton!

    private var repositoryProperties = [RepositoryProperty]()

    @IBAction private func onOpenButton() {
    }
}

extension RepoDetilsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryProperties.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: RepositoryPropertyCell.self, for: indexPath)
        return cell
    }
}
