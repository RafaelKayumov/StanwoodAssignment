//
//  RootTabControllerViewInput.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 02/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

protocol RootTabControllerViewInput: class {
    func selectPeriod(_ period: Repository.CreationPeriod)
}
