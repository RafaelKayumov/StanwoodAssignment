//
//  URLResponse+Additions.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 02/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

private let kLinkHeader = "Link"

extension URLResponse {

    private enum Page: String {
        case next
        case first
        case last

        var keyValue: String {
            return "rel=\"\(self.rawValue)\""
        }
    }

    var nextPageURL: URL? {
        guard
            let httpURLResponse = self as? HTTPURLResponse,
            let linksString = httpURLResponse.allHeaderFields[kLinkHeader] as? String
        else {
            return nil
        }

        let links = linksString.components(separatedBy: ",")
        let linksDictionary = links.reduce([String: String]()) {
            let components = $1.components(separatedBy:"; ")
            let cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "< >"))
            let keyValuePairToAppend = [components[1]: cleanPath]
            return $0.merging(keyValuePairToAppend) { (_, new) in new }
        }

        guard let nextPageURLString = linksDictionary[Page.next.keyValue] else { return nil }
        return URL(string: nextPageURLString)
    }
}
