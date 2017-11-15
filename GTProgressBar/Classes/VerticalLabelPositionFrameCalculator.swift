//
//  VerticalFrameCalculator.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 06/05/2017.
//
//

import Foundation

internal protocol VerticalLabelPositionFrameCalculator: FrameCalculator {
    func backgroundViewOrigin() -> CGPoint
}

extension VerticalLabelPositionFrameCalculator {
    
    func sizeThatFits(_ size: CGSize) -> CGSize {
        let labelContainerSize = self.labelContainerSize()
        let totalHeight = labelContainerSize.height + orientationBasedMinimumHeight()
        
        var height: CGFloat = 0
        if  let _ = barMaxHeight {
            height = totalHeight
        } else {
            height = max(size.height, totalHeight)
        }
        
        let width =  max(size.width, max(labelContainerSize.width, minimumProgressBarWidth))
        
        return CGSize(width: width, height: height)
    }
    
    private func orientationBasedMinimumHeight() -> CGFloat {
        let totalBorderHeight = barBorderWidth * 2.0
        let totalInsetHeight = barFillInset * 2.0
        var minimumBarHeight = totalBorderHeight + totalInsetHeight + minimumProgressBarFillHeight
        
        if orientation == .vertical {
            minimumBarHeight = max(minimumBarHeight, minimumProgressBarHeightForVerticalOrientation)
        }
        
        return max(minimumBarHeight, barMaxHeight ?? minimumBarHeight)
    }
    
    func centerLabel(label: UILabel) {
        if let parent = label.superview {
            label.centerHorizontally(parent: parent)
        }
    }
    
    func centerBar(bar: UIView) {
        if let parent = bar.superview {
            bar.centerHorizontally(parent: parent)
        }
    }
    
    public func backgroundViewFrame() -> CGRect {
        let height = min(parentFrame.size.height - labelContainerSize().height, barMaxHeight ?? parentFrame.size.height)
        let width = min(barMaxWidth ?? parentFrame.width, parentFrame.width)
        
        return CGRect(origin: backgroundViewOrigin(), size:  CGSize(width: width, height: height))
    }
}

internal class LabelTopFrameCalculator: VerticalLabelPositionFrameCalculator {
    let hasLabel: Bool
    let parentFrame: CGRect
    let barMaxHeight: CGFloat?
    let barMaxWidth: CGFloat?
    let insets: UIEdgeInsets
    let font: UIFont
    let barBorderWidth: CGFloat
    let barFillInset: CGFloat
    let orientation: GTProgressBarOrientation
    let direction: GTProgressBarDirection
    
    public init(progressBar: GTProgressBar) {
        self.hasLabel = progressBar.displayLabel
        self.barMaxHeight = progressBar.barMaxHeight
        self.barMaxWidth = progressBar.barMaxWidth
        self.parentFrame = progressBar.frame
        self.insets = progressBar.progressLabelInsets
        self.font = progressBar.font
        self.barBorderWidth = progressBar.barBorderWidth
        self.barFillInset = progressBar.barFillInset
        self.orientation = progressBar.orientation
        self.direction = progressBar.direction
    }
    
    func backgroundViewOrigin() -> CGPoint {
        return CGPoint(x: 0, y: labelContainerSize().height)
    }
    
    func labelOrigin() -> CGPoint {
        return CGPoint(x: 0, y: self.insets.top)
    }
}

internal class LabelBottomFrameCalculator: VerticalLabelPositionFrameCalculator {
    let hasLabel: Bool
    let parentFrame: CGRect
    let barMaxHeight: CGFloat?
    let barMaxWidth: CGFloat?
    let insets: UIEdgeInsets
    let font: UIFont
    let barBorderWidth: CGFloat
    let barFillInset: CGFloat
    let orientation: GTProgressBarOrientation
    let direction: GTProgressBarDirection
    
    public init(progressBar: GTProgressBar) {
        self.hasLabel = progressBar.displayLabel
        self.barMaxHeight = progressBar.barMaxHeight
        self.barMaxWidth = progressBar.barMaxWidth
        self.parentFrame = progressBar.frame
        self.insets = progressBar.progressLabelInsets
        self.font = progressBar.font
        self.barBorderWidth = progressBar.barBorderWidth
        self.barFillInset = progressBar.barFillInset
        self.orientation = progressBar.orientation
        self.direction = progressBar.direction
    }
    
    func backgroundViewOrigin() -> CGPoint {
        return CGPoint.zero
    }
    
    func labelOrigin() -> CGPoint {
        return CGPoint(x: 0, y: self.backgroundViewFrame().height + self.insets.top)
    }
}
