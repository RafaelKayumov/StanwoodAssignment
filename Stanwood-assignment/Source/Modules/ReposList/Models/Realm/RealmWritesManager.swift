//
//  RealmWritesManager.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 03/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmWritesManager {

    private static var realmWritesQueue = DispatchQueue(label: "RealmOperations", qos: .userInitiated)

    static func writeAsync(_ writes: @escaping () -> Void) {
        realmWritesQueue.async {
            writes()
        }
    }
}
