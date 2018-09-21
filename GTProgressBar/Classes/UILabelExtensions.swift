//
//  UILabelExtensions.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 14/04/2017.
//
//

import Foundation

internal extension UILabel {
    internal static func sizeFor(content: NSString, font: UIFont) -> CGSize {
        let text: NSString = content
      
        #if swift(>=4.2)
        let textSize = text.size(withAttributes: [NSAttributedString.Key.font : font])
        #else
        let textSize = text.size(withAttributes: [NSAttributedStringKey.font : font])
        #endif
      
        return CGSize(width: ceil(textSize.width), height: ceil(textSize.height))
    }
}
