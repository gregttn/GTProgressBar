//
//  FrameCalculator.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 15/04/2017.
//
//

import Foundation

internal protocol FrameCalculator {
    var minimumProgressBarWidth: CGFloat {get}
    var minimumProgressBarFillHeight: CGFloat {get}

    var hasLabel: Bool {get}
    var insets: UIEdgeInsets {get}
    var barBorderWidth: CGFloat {get}
    var barFillInset: CGFloat {get}
    var barMaxHeight: CGFloat? {get}
    
    func labelFrame() -> CGRect
    func backgroundViewFrame() -> CGRect
    
    func center(view: UIView, parent: UIView)
    func sizeThatFits(_ size: CGSize) -> CGSize
}

extension FrameCalculator {
    var minimumProgressBarWidth: CGFloat { return 20}
    var minimumProgressBarFillHeight: CGFloat { return 1 }
}

extension FrameCalculator {
    func labelContainerSize() -> CGSize {
        if (!self.hasLabel) {
            return CGSize.zero
        }
        
        return CGSize(
            width: labelFrame().width + insets.left + insets.right,
            height: labelFrame().height + insets.top + insets.bottom
        )
    }
}

protocol VerticalFrameCalculator: FrameCalculator {}
protocol HorizontalFrameCalculator: FrameCalculator {}

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
        
        return CGRect(origin: origin, size: UILabel.sizeFor(content: "100%", font: self.font))
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
        
        let size = UILabel.sizeFor(content: "100%", font: self.font)
        let origin = CGPoint(x: 0, y: self.insets.top)
        
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
        let height = min(parentFrame.size.height - labelContainerSize().height, barMaxHeight ?? parentFrame.size.height)
        let width = parentFrame.width
        let origin = CGPoint(x: 0, y: labelContainerSize().height)
        
        return CGRect(origin: origin, size: CGSize(width: width, height: height))
    }
}

