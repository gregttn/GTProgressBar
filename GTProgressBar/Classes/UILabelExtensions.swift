//
//  UILabelExtensions.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 14/04/2017.
//
//

import Foundation

extension UILabel {
    public static func sizeFor(content: NSString, font: UIFont) -> CGSize {
        let text: NSString = content
        let textSize = text.size(attributes: [NSFontAttributeName : font])
        
        return CGSize(width: ceil(textSize.width), height: ceil(textSize.height))
    }
}
