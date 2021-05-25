//
//  GTProgressBarCornerType.swift
//  GTProgressBar
//
//  Created by greg on 12/04/2018.
//

import Foundation

public enum GTProgressBarCornerType: Int {
    case square
    
    /// All corners rounded.
    case rounded
    
    
    /// top left & top right
    @available(iOS 11.0, *)
    case topCornersOnly
    
    /// Bottom left + bottom right
    @available(iOS 9.0, *)
    case bottomCornersOnly
    
   
}


