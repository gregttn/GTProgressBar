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
    var font: UIFont {get}
    
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
            width: labelFrameSize().width + insets.left + insets.right,
            height: labelFrameSize().height + insets.top + insets.bottom
        )
    }
    
    func labelFrameSize() -> CGSize {
        return UILabel.sizeFor(content: "100%", font: self.font)
    }
}
