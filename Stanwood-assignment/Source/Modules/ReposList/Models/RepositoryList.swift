//
//  RepositoryList.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

struct RepositoryList {

    private var repos = [RepositoryPlain]()
    private(set) var nextPageURL: URL?
    var totalExisting = 0

    mutating func applyReposBatch(_ repos: [RepositoryPlain], nextPageURL: URL?) {
        self.repos.append(contentsOf: repos)
        self.nextPageURL = nextPageURL
    }

    mutating func clear() {
        repos = []
        nextPageURL = nil
        totalExisting = 0
    }

    var count: Int {
        return repos.count
    }

    var allLoaded: Bool {
        return totalExisting == count
    }

    func index(ofRepoWith id: Int) -> Int? {
        return repos.firstIndex {
            return $0.id == id
        }
    }

    subscript(index: Int) -> RepositoryPlain? {
        guard repos.indices.contains(index) else { return nil }
        return repos[index]
    }
}
