//
//  RepositoryList.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

struct RepositoryList {

    private var repos = [Repository]()

    mutating func applyRepos(_ repos: [Repository]) {
        self.repos = repos
    }

    func insertRepo(_ repo: Repository, at index: Int) {

    }

    func removeAt(_ index: Int) {

    }

    func appendRepos(_ repos: [Repository]) {

    }

    func insertReposToBeginning(_ repos: [Repository]) {

    }

    var count: Int {
        return repos.count
    }

    subscript(index: Int) -> Repository? {
        guard repos.indices.contains(index) else { return nil }
        return repos[index]
    }
}
