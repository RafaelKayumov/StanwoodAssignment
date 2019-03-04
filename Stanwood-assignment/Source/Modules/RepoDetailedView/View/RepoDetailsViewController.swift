//
//  RepoDetailsViewController.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 04/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var openRepoButton: UIButton!
    @IBOutlet private var descriptionContainer: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!

    private var repositoryProperties = [RepositoryProperty]()

    var output: RepoDetailsViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        openRepoButton.isHidden = true
    }

    @IBAction private func onOpenButton() {
        output.onOpenOnGithub()
    }
}

extension RepoDetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryProperties.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: RepositoryPropertyCell.self, for: indexPath)
        let repositoryProperty = repositoryProperties[indexPath.row]
        cell.configure(with: repositoryProperty)
        return cell
    }
}

extension RepoDetailsViewController: RepoDetailsViewInput {

    func displayRepository(_ repository: Repository) {
        title = repository.name
        if let descriptionText = repository.repoDescription, descriptionText.isEmpty == false {
            descriptionLabel.text = descriptionText
            tableView.tableHeaderView = descriptionContainer
        } else {
            tableView.tableHeaderView = nil
        }

        repositoryProperties = RepositoryProperty.properties(for: repository)
        tableView.reloadData()

        openRepoButton.isHidden = repository.url == nil
    }
}
