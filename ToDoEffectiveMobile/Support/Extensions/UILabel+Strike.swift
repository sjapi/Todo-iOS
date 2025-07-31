//
//  UILabel+Strike.swift
//  ToDoEffectiveMobile
//
//  Created by Arseniy Zolotarev on 30.07.2025.
//

import UIKit

extension UILabel {
    func setStrikeThrough(_ isStriked: Bool, text: String) {
        if isStriked {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(
                .strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: attributedString.length)
            )
            self.attributedText = attributedString
        } else {
            self.attributedText = nil
            self.text = text
        }
    }
}
