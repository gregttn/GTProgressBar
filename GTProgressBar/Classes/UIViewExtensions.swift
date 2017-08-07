//
//  UIViewExtensions.swift
//  Pods
//
//  Created by greg on 07/08/2017.
//
//

import UIKit

internal extension UIView {
    internal func centerHorizontally(parent: UIView) {
        let center = parent.convert(parent.center, from: parent.superview)
        self.center = CGPoint(x: center.x, y: self.center.y)
    }
    
    internal func centerVertically(parent: UIView) {
        let center = parent.convert(parent.center, from: parent.superview)
        self.center = CGPoint(x: self.center.x, y: center.y)
    }
}
