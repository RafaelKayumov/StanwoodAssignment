//
//  RepoCell.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 27/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit

extension Repository {

    var displayTitle: String {
        return [owner.login, name].joined(separator: "/")
    }

    var displayStargazersText: String {
        return stargazersCount.kFormatted
    }
}

class RepoCell: UICollectionViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var favoriteIndicator: UIImageView!
    @IBOutlet private weak var stargazersLabel: UILabel!

    func configureWithRepo(_ repo: Repository) {
        titleLabel.text = repo.displayTitle
        descriptionLabel.text = repo.description
        stargazersLabel.text = repo.displayStargazersText
    }
}
