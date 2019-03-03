//
//  QueryFilter.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 02/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

struct QueryFilter {
    var creationPeriod = RepositoryPlain.CreationPeriod.day
    var searchString: String?
}

extension QueryFilter {

    var realmQueryFormatAndArguments: (format: String, arguments: [Any]) {
        var queryFormatComponents = [String]()
        var queryArguments = [Any]()

        queryFormatComponents.append("createdAt >= %@")
        queryArguments.append(creationPeriod.thresholdDate)

        if let searchString = self.searchString {
            let keypathsToSearchIn = ["name", "repoDescription", "owner.login"]
            let entities = searchString.containingQueryFormatAndArguments(for: keypathsToSearchIn)
            queryFormatComponents.append(entities.format)
            queryArguments.append(entities.arguments)
        }

        return (queryFormatComponents.joined(separator: " && "), queryArguments)
    }
}

extension String {

    func containingQueryString(for keypaths: [String]) -> String {
        let format = "%@ CONTAINS[c] \"%@\""
        let separator = " || "
        let queryComponents = keypaths.map { String(format: format, $0, self) }
        return "(" + queryComponents.joined(separator: separator) + ")"
    }

    func containingQueryFormatAndArguments(for keypaths: [String]) -> (format: String, arguments: [Any]) {
        let format = "%@ CONTAINS[c] \"%@\""
        let separator = " || "
        let queryComponents = keypaths.map { String(format: format, $0) }
        let arguments = [String](repeating: self, count: keypaths.count)
        return ("(" + queryComponents.joined(separator: separator) + ")", arguments)
    }
}
