//
//  RepoCell.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 27/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit
import Kingfisher

extension Repository {

    var displayTitle: String {
        var components = [name]
        if let login = owner?.login {
            components.insert(login, at: 0)
        }
        return components.joined(separator: "/")
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
    weak var delegate: RepoCellDelegate?

    func configureWithRepo(_ repo: Repository) {
        titleLabel.text = repo.displayTitle
        descriptionLabel.text = repo.description
        stargazersLabel.text = repo.displayStargazersText

        avatarImageView.image = nil
        if let ownerAvatarURL = repo.owner?.avatarURL {
            avatarImageView.kf.setImage(
                with: ownerAvatarURL,
                placeholder: nil,
                options: [
                    .cacheOriginalImage
                ])
        }
    }
}

extension RepoCell: SwitcherImageViewDelegate {
    func onSwitcherImageView(_ switcherImageView: SwitcherImageView, enabled: Bool) {
        delegate?.repoCell(self, didToggleFavoriteStateTo: enabled)
    }
}

protocol RepoCellDelegate: class {
    func repoCell(_ repoCell: RepoCell, didToggleFavoriteStateTo value: Bool)
}
