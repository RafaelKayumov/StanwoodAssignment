//
//  RepositoryPropertyCell.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 04/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit

class RepositoryPropertyCell: UITableViewCell {

    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    func configure(with property: RepositoryProperty) {
        icon.image = property.icon

        switch property {
        case .creationDate(let date):
            let agoText = date.timeAgoDisplay()
            titleLabel.text = "Created \(agoText) ago at \(date.compactString)"
        case .forks(let forks):
            titleLabel.text = "\(forks) forks"
        case .languages(let languages):
            titleLabel.text = languages.joined(separator: ", ")
        case .stars(let stars):
            titleLabel.text = "\(stars) stars"
        }
    }
}
