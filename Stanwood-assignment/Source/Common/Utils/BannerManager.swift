//
//  BannerManager.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 04/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit
import SwiftEntryKit

class BannerManager {

    static func displayOfflineBanner() {
        var attributes = EKAttributes()
        attributes = .statusBar
        attributes.displayDuration = .infinity
        attributes.hapticFeedbackType = .error
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .red)

        let statusBarHeight = UIApplication.shared.statusBarFrame.maxY

        let contentView: UIView
        let font = UIFont.systemFont(ofSize: 12)
        let labelStyle = EKProperty.LabelStyle(font: font, color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: "Offline", style: labelStyle)
        let noteView = EKNoteMessageView(with: labelContent)
        noteView.verticalOffset = 0
        noteView.set(.height, of: statusBarHeight)
        contentView = noteView

        SwiftEntryKit.display(entry: contentView, using: attributes)
    }

    static func dismissOfflineBanner() {
        SwiftEntryKit.dismiss()
    }
}
