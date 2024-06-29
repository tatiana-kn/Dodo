//
//  UIView+Shadow.swift
//  Dodo
//
//  Created by Tia M on 6/29/24.
//

import UIKit

extension UIView {
    func applyShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
