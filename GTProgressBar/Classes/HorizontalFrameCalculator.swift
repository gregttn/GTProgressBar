//
//  HorizontalFrameCalculator.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 06/05/2017.
//
//

import Foundation

internal protocol HorizontalFrameCalculator: FrameCalculator {}

extension HorizontalFrameCalculator {
    func sizeThatFits(_ size: CGSize) -> CGSize {
        let minProgressBarHeight = (barBorderWidth * 2.0) + (barFillInset * 2.0) + minimumProgressBarFillHeight
        let labelContainerSize = self.labelContainerSize()
        
        let height = max(labelContainerSize.height, minProgressBarHeight)
        let width =  max(size.width, labelContainerSize.width + minimumProgressBarWidth)
        
        return CGSize(width: width, height: height)
    }
    
    func center(view: UIView, parent: UIView) {
        let center = parent.convert(parent.center, from: parent.superview)
        view.center = CGPoint(x: view.center.x, y: center.y)
    }
}

internal class LabelLeftFrameCalculator: HorizontalFrameCalculator {
    let hasLabel: Bool
    let parentFrame: CGRect
    let insets: UIEdgeInsets
    let font: UIFont
    let barBorderWidth: CGFloat
    let barFillInset: CGFloat
    var barMaxHeight: CGFloat?
    
    lazy private var _labelFrame: CGRect = {
        if (!self.hasLabel) {
            return CGRect.zero
        }
        
        let origin = CGPoint(x: self.insets.left, y: 0)
        
        return CGRect(origin: origin, size: self.labelFrameSize())
    }()
    
    public init(progressBar: GTProgressBar) {
        self.hasLabel = progressBar.displayLabel
        self.barMaxHeight = progressBar.barMaxHeight
        self.parentFrame = progressBar.frame
        self.insets = progressBar.progressLabelInsets
        self.font = progressBar.font
        self.barBorderWidth = progressBar.barBorderWidth
        self.barFillInset = progressBar.barFillInset
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

internal class LabelRightFrameCalculator: HorizontalFrameCalculator {
    let hasLabel: Bool
    let parentFrame: CGRect
    let barMaxHeight: CGFloat?
    let insets: UIEdgeInsets
    let font: UIFont
    let barBorderWidth: CGFloat
    let barFillInset: CGFloat
    
    lazy private var _labelFrame: CGRect = {
        if (!self.hasLabel) {
            return CGRect.zero
        }
        
        let size = self.labelFrameSize()
        let origin = CGPoint(x: self.parentFrame.size.width - self.insets.right - size.width, y: 0)
        
        return CGRect(origin: origin, size: size)
    }()
    
    public init(progressBar: GTProgressBar) {
        self.hasLabel = progressBar.displayLabel
        self.barMaxHeight = progressBar.barMaxHeight
        self.parentFrame = progressBar.frame
        self.insets = progressBar.progressLabelInsets
        self.font = progressBar.font
        self.barBorderWidth = progressBar.barBorderWidth
        self.barFillInset = progressBar.barFillInset
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
