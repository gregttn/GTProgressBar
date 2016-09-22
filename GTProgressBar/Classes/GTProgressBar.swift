//
//  GTProgressBar.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 19/09/2016.
//
//

import UIKit

public class GTProgressBar: UIView {
    private let backgroundView = UIView()
    private let fillView = UIView()
    private let backgroundViewBorder: CGFloat = 2
    private let backgroundViewBackgroundColor: UIColor = UIColor.white
    private let fillViewInset: CGFloat = 2
    private let fillViewBackgroundColor = UIColor.black
    private var _progress: CGFloat = 1
    
    public var barBorderColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    public var progress: CGFloat {
        get {
            return self._progress
        }
        
        set {
            if newValue < 0 {
                self._progress = 0
            } else if newValue > 1 {
                self._progress = 1
            } else {
                self._progress = newValue
            }
            
            self.setNeedsLayout()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareSubviews()
    }
    
    private func prepareSubviews() {
        addSubview(backgroundView)
        addSubview(fillView)
    }
    
    public override func layoutSubviews() {
        setupBackgroundView()
        setupFillView()
    }
    
    private func setupBackgroundView() {
        backgroundView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
        backgroundView.backgroundColor = backgroundViewBackgroundColor
        backgroundView.layer.borderWidth = backgroundViewBorder
        backgroundView.layer.borderColor = barBorderColor.cgColor
        backgroundView.layer.cornerRadius = cornerRadiusFor(view: backgroundView)
    }
    
    private func setupFillView() {
        let offset = backgroundViewBorder + fillViewInset
        let fillFrame = backgroundView.frame.insetBy(dx: offset, dy: offset)
        let fillFrameAdjustedSize = CGSize(width: fillFrame.width * _progress, height: fillFrame.height)
        
        fillView.frame = CGRect(origin: fillFrame.origin, size: fillFrameAdjustedSize)
        fillView.backgroundColor = fillViewBackgroundColor
        fillView.layer.cornerRadius = cornerRadiusFor(view: fillView)
    }
    
    private func cornerRadiusFor(view: UIView) -> CGFloat {
        return view.frame.height / 2 * 0.7
    }
}
