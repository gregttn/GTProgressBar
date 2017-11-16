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
    var minimumProgressBarHeightForVerticalOrientation: CGFloat {get}

    var hasLabel: Bool {get}
    var insets: UIEdgeInsets {get}
    var barBorderWidth: CGFloat {get}
    var barFillInset: CGFloat {get}
    var barMaxHeight: CGFloat? {get}
    var barMaxWidth: CGFloat? {get}
    var font: UIFont {get}
    var orientation: GTProgressBarOrientation {get}
    var direction: GTProgressBarDirection {get}
    var parentFrame: CGRect {get}
    
    func labelFrame() -> CGRect
    func labelOrigin() -> CGPoint
    func backgroundViewFrame() -> CGRect
    
    func centerLabel(label: UILabel)
    func centerBar(bar: UIView)
    func sizeThatFits(_ size: CGSize) -> CGSize
    
}

extension FrameCalculator {
    var minimumProgressBarWidth: CGFloat { return 20}
    var minimumProgressBarHeightForVerticalOrientation: CGFloat { return 20}
    var minimumProgressBarFillHeight: CGFloat { return 1 }
}

extension FrameCalculator {
    public func labelFrame() -> CGRect {
        if (!self.hasLabel) {
            return CGRect.zero
        }
        
        return CGRect(origin: labelOrigin(), size: self.labelFrameSize())
    }
    
    func labelContainerSize() -> CGSize {
        if (!self.hasLabel) {
            return CGSize.zero
        }
        
        return CGSize(
            width: labelFrameSize().width + insets.left + insets.right,
            height: labelFrameSize().height + insets.top + insets.bottom
        )
    }
    
    func labelFrameSize() -> CGSize {
        return UILabel.sizeFor(content: "100%", font: self.font)
    }
}

extension FrameCalculator {
    func fillViewFrameFor(progress: CGFloat) -> CGRect {
        let offset = barFillInset == 0 ? 0 : barBorderWidth + barFillInset
        let backgroundFrame = backgroundViewFrame()
        let fillFrame = backgroundFrame.insetBy(dx: offset, dy: offset)
        
        switch orientation {
        case .horizontal:
            let fillFrameAdjustedSize = CGSize(width: fillFrame.width * progress, height: fillFrame.height)
            let directionXCoordinateAdjustement = direction == .clockwise ? 0.0 : fillFrame.width - fillFrameAdjustedSize.width
            let origin = CGPoint(x: offset + directionXCoordinateAdjustement, y: offset)
            
            return CGRect(origin: origin, size: fillFrameAdjustedSize)
        case .vertical:
            let fillFrameAdjustedSize = CGSize(width: fillFrame.width, height: fillFrame.height * progress)
            let directionYCoordinateAdjustement = direction == .clockwise ? fillFrame.height - fillFrameAdjustedSize.height : 0.0
            let origin = CGPoint(x: offset, y: offset + directionYCoordinateAdjustement)
            
            return CGRect(origin: origin, size: fillFrameAdjustedSize)
        }
    }
}
