//
//  ReposListViewOutput.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

protocol ReposListViewOutput: ViewOutput {
    func onCellSelectAtIndex(_ index: Int)
    func repoCell(at index: Int, didToggleFavoriteStateTo value: Bool)
}
