//
//  HorizontalFrameCalculator.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 06/05/2017.
//
//

import Foundation

internal protocol HorizontalLabelPositionFrameCalculator: FrameCalculator {
    func backgroundViewOrigin() -> CGPoint
}

extension HorizontalLabelPositionFrameCalculator {
    func sizeThatFits(_ size: CGSize) -> CGSize {
        let minProgressBarHeight = orientationBasedMinHeight()
        
        let labelContainerSize = self.labelContainerSize()
        let height = max(labelContainerSize.height, minProgressBarHeight)
        let width =  max(size.width, labelContainerSize.width + minimumProgressBarWidth)
        
        return CGSize(width: width, height: height)
    }
    
    private func orientationBasedMinHeight() -> CGFloat {
        let totalBorderHeight = barBorderWidth * 2.0
        let totalInsetHeight = barFillInset * 2.0
        var minProgressBarHeight =  totalBorderHeight + totalInsetHeight + minimumProgressBarFillHeight
        
        if orientation == .vertical {
            minProgressBarHeight = max(minProgressBarHeight, minimumProgressBarHeightForVerticalOrientation)
        }
        
        return minProgressBarHeight
    }
    
    func centerLabel(label: UILabel) {
        if let parent = label.superview {
             label.centerVertically(parent: parent)
        }
    }
    
    func centerBar(bar: UIView) {
        guard let parent = bar.superview else { return }
        
        if hasLabel {
            bar.centerVertically(parent: parent)
        } else {
            bar.centerHorizontally(parent: parent)
        }
    }
    
    public func backgroundViewFrame() -> CGRect {
        let xOffset = labelContainerSize().width
        let height = min(self.barMaxHeight ?? parentFrame.size.height, parentFrame.size.height)
        let width = min(self.barMaxWidth ?? parentFrame.size.width - xOffset, parentFrame.size.width - xOffset)
        let size = CGSize(width: width, height: height)
        
        return CGRect(origin: backgroundViewOrigin(), size: size)
    }
}

internal class LabelLeftFrameCalculator: HorizontalLabelPositionFrameCalculator {
    let hasLabel: Bool
    let parentFrame: CGRect
    let insets: UIEdgeInsets
    let font: UIFont
    let barBorderWidth: CGFloat
    let barFillInset: CGFloat
    var barMaxHeight: CGFloat?
    var barMaxWidth: CGFloat?
    var orientation: GTProgressBarOrientation
    var direction: GTProgressBarDirection
    
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
    
    func labelOrigin() -> CGPoint {
        return CGPoint(x: self.insets.left, y: 0)
    }
    
    func backgroundViewOrigin() -> CGPoint {
        return CGPoint(x: labelContainerSize().width, y: 0)
    }
}

internal class LabelRightFrameCalculator: HorizontalLabelPositionFrameCalculator {
    let hasLabel: Bool
    let parentFrame: CGRect
    let barMaxHeight: CGFloat?
    let barMaxWidth: CGFloat?
    let insets: UIEdgeInsets
    let font: UIFont
    let barBorderWidth: CGFloat
    let barFillInset: CGFloat
    var orientation: GTProgressBarOrientation
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
    
    func labelOrigin() -> CGPoint {
        let size = self.labelFrameSize()
        
        return CGPoint(x: self.parentFrame.size.width - self.insets.right - size.width, y: 0)
    }
    
    func backgroundViewOrigin() -> CGPoint {
        return CGPoint.zero
    }
}
