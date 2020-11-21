//
//  UIView.swift
//  Homework5
//
//  Created by Михаил Жданов on 15.11.2020.
//

import UIKit

extension UIView {
    
    @discardableResult
    func pin(_ attribute: NSLayoutConstraint.Attribute, to secondAttribute: NSLayoutConstraint.Attribute = .notAnAttribute,
             of item: Any? = nil, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0,
             multiplier: CGFloat = 1, activate isActive: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: relation,
            toItem: item,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant
        )
        constraint.isActive = isActive
        return constraint
    }
    
}
