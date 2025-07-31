//
//  ExtendedTapAreaButton.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 31.07.2025.
//

import UIKit

final class ExtendedTapAreaButton: UIButton {
    var extraTapArea: UIEdgeInsets = .zero

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let largerBounds = bounds.insetBy(dx: -extraTapArea.left, dy: -extraTapArea.top)
        let extendedBounds = bounds.inset(by: UIEdgeInsets(
            top: -extraTapArea.top,
            left: -extraTapArea.left,
            bottom: -extraTapArea.bottom,
            right: -extraTapArea.right
        ))
        return extendedBounds.contains(point)
    }
}
