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
    private(set) var nextPageURL: URL?

    mutating func applyReposBatch(_ repos: [Repository], nextPageURL: URL?) {
        self.repos = repos
        self.nextPageURL = nextPageURL
    }

    var count: Int {
        return repos.count
    }

    subscript(index: Int) -> Repository? {
        guard repos.indices.contains(index) else { return nil }
        return repos[index]
    }
}
