//
//  FrameCalculator.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 15/04/2017.
//
//

import Foundation

internal protocol FrameCalculator {
    func labelFrame() -> CGRect
    func backgroundViewFrame() -> CGRect
}

internal class LabelLeftFrameCalculator: FrameCalculator {
    let hasLabel: Bool
    let parentFrame: CGRect
    let barMaxHeight: CGFloat?
    let insets: UIEdgeInsets
    let font: UIFont
    
    public init(progressBar: GTProgressBar) {
        self.hasLabel = progressBar.displayLabel
        self.barMaxHeight = progressBar.barMaxHeight
        self.parentFrame = progressBar.frame
        self.insets = progressBar.progressLabelInsets
        self.font = progressBar.font
    }
    
    public func labelFrame() -> CGRect {
        let origin = CGPoint(x: insets.left, y: 0)
        
        return CGRect(origin: origin, size: UILabel.sizeFor(content: "100%", font: font))
    }
    
    public func backgroundViewFrame() -> CGRect {
        let xOffset = backgroundViewXOffset()
        let height = min(self.barMaxHeight ?? parentFrame.size.height, parentFrame.size.height)
        let size = CGSize(width: parentFrame.size.width - xOffset, height: height)
        let origin = CGPoint(x: xOffset, y: 0)
        
        return CGRect(origin: origin, size: size)
    }
    
    private func backgroundViewXOffset() -> CGFloat {
        return hasLabel ? labelFrame().width + insets.left + insets.right : 0.0
    }
}
