//
//  Int+Additions.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 27/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

extension Int {
    var kFormatted: String {
        return String(format: self >= 1000 ? "%dK" : "%d", (self >= 1000 ? self/1000 : self))
    }
}
