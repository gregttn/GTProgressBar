//
//  VerticalFrameCalculator.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 06/05/2017.
//
//

import Foundation

internal protocol VerticalFrameCalculator: FrameCalculator {}

extension VerticalFrameCalculator {
    
    func center(view: UIView, parent: UIView) {
        let center = parent.convert(parent.center, from: parent.superview)
        view.center = CGPoint(x: center.x, y: view.center.y)
    }
    
    func sizeThatFits(_ size: CGSize) -> CGSize {
        let minProgressBarHeight = (barBorderWidth * 2.0) + (barFillInset * 2.0) + minimumProgressBarFillHeight
        let labelContainerSize = self.labelContainerSize()
        let totalHeight = labelContainerSize.height + max(minProgressBarHeight, barMaxHeight ?? minProgressBarHeight)
        
        var height: CGFloat = 0
        if  let _ = barMaxHeight {
            height = totalHeight
        } else {
            height = max(size.height, totalHeight)
        }
        
        let width =  max(size.width, max(labelContainerSize.width, minimumProgressBarWidth))
        
        return CGSize(width: width, height: height)
    }
}

internal class LabelTopFrameCalculator: VerticalFrameCalculator {
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
    
        let origin = CGPoint(x: 0, y: self.insets.top)
        
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
        let height = min(parentFrame.size.height - labelContainerSize().height, barMaxHeight ?? parentFrame.size.height)
        let width = parentFrame.width
        let origin = CGPoint(x: 0, y: labelContainerSize().height)
        
        return CGRect(origin: origin, size: CGSize(width: width, height: height))
    }
}

internal class LabelBottomFrameCalculator: VerticalFrameCalculator {
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
        
        let origin = CGPoint(x: 0, y: self.backgroundViewFrame().height + self.insets.top)
        
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
        let height = min(parentFrame.height - labelContainerSize().height, barMaxHeight ?? parentFrame.size.height)
        let size = CGSize(width: parentFrame.width, height: height)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
}
