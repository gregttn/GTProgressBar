//
//  FrameCalculator.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 15/04/2017.
//
//

import Foundation

internal protocol FrameCalculator {
    var hasLabel: Bool {get}
    var insets: UIEdgeInsets {get}
    
    func labelFrame() -> CGRect
    func backgroundViewFrame() -> CGRect

}

extension FrameCalculator {
    func labelContainerSize() -> CGSize {
        if (!self.hasLabel) {
            return CGSize.zero
        }
        
        return CGSize(
            width: labelFrame().width + insets.left + insets.right,
            height: labelFrame().height
        )
    }
}

internal class LabelLeftFrameCalculator: FrameCalculator {
    let hasLabel: Bool
    let parentFrame: CGRect
    let barMaxHeight: CGFloat?
    let insets: UIEdgeInsets
    let font: UIFont
    
    lazy private var _labelFrame: CGRect = {
        if (!self.hasLabel) {
            return CGRect.zero
        }
        
        let origin = CGPoint(x: self.insets.left, y: 0)
        
        return CGRect(origin: origin, size: UILabel.sizeFor(content: "100%", font: self.font))
    }()
    
    public init(progressBar: GTProgressBar) {
        self.hasLabel = progressBar.displayLabel
        self.barMaxHeight = progressBar.barMaxHeight
        self.parentFrame = progressBar.frame
        self.insets = progressBar.progressLabelInsets
        self.font = progressBar.font
    }
    
    public func labelFrame() -> CGRect {
        return _labelFrame
    }
    
    public func backgroundViewFrame() -> CGRect {
        let xOffset = labelContainerSize().width
        let height = min(self.barMaxHeight ?? parentFrame.size.height, parentFrame.size.height)
        let size = CGSize(width: parentFrame.size.width - xOffset, height: height)
        let origin = CGPoint(x: xOffset, y: 0)
        
        return CGRect(origin: origin, size: size)
    }
}

internal class LabelRightFrameCalculator: FrameCalculator {
    let hasLabel: Bool
    let parentFrame: CGRect
    let barMaxHeight: CGFloat?
    let insets: UIEdgeInsets
    let font: UIFont
    
    lazy private var _labelFrame: CGRect = {
        if (!self.hasLabel) {
            return CGRect.zero
        }
        
        let size = UILabel.sizeFor(content: "100%", font: self.font)
        let origin = CGPoint(x: self.parentFrame.size.width - self.insets.right - size.width, y: 0)
        
        return CGRect(origin: origin, size: size)
    }()
    
    public init(progressBar: GTProgressBar) {
        self.hasLabel = progressBar.displayLabel
        self.barMaxHeight = progressBar.barMaxHeight
        self.parentFrame = progressBar.frame
        self.insets = progressBar.progressLabelInsets
        self.font = progressBar.font
    }
    
    public func labelFrame() -> CGRect {
        return _labelFrame
    }
    
    public func backgroundViewFrame() -> CGRect {
        let height = min(self.barMaxHeight ?? parentFrame.size.height, parentFrame.size.height)
        let width = hasLabel ? parentFrame.size.width -  labelContainerSize().width : parentFrame.size.width
        let size = CGSize(width: width, height: height)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
}
