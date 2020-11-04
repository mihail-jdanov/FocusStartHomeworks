//
//  UIView.swift
//  Homework4
//
//  Created by Михаил Жданов on 04.11.2020.
//  Copyright © 2020 Михаил Жданов. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func pin(_ firstAttribute: NSLayoutConstraint.Attribute, to secondAttribute: NSLayoutConstraint.Attribute = .notAnAttribute,
             of item: Any? = nil, constant: CGFloat = 0, multiplier: CGFloat = 1,
             activate isActive: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: firstAttribute,
            relatedBy: .equal,
            toItem: item,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant
        )
        constraint.isActive = isActive
        return constraint
    }
    
}
