//
//  RepositoryOptions.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 04/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

enum RepositoryProperty {
    case languages([String])
    case forks(Int)
    case stars(Int)
    case creationDate(Date)
}

extension RepositoryProperty {

    var icon: UIImage {
        var imageName: String
        switch self {
        case .creationDate:
            imageName = "date"
        case .forks:
            imageName = "fork"
        case .languages:
            imageName = "language"
        case .stars:
            imageName = "star"
        }
        return UIImage(named: imageName)!
    }

    static func properties(for repository: Repository) -> [RepositoryProperty] {
        var properties = [RepositoryProperty]()

        if let language = repository.language, language.isEmpty == false {
            properties.append(.languages([language]))
        }

        if repository.forks > 0 {
            properties.append(.forks(repository.forks))
        }

        if repository.stargazersCount > 0 {
            properties.append(.stars(repository.stargazersCount))
        }

        if let date = repository.createdAt {
            properties.append(.creationDate(date))
        }

        return properties
    }
}
