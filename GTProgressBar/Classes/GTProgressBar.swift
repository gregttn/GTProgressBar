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
    private let backgroundViewBorderColor: UIColor = UIColor.black
    private let backgroundViewBackgroundColor: UIColor = UIColor.white
    private let fillViewInset: CGFloat = 2
    private let fillViewBackgroundColor = UIColor.black

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
        backgroundView.layer.borderColor = backgroundViewBorderColor.cgColor
        backgroundView.layer.cornerRadius = cornerRadiusFor(view: backgroundView)
    }
    
    private func setupFillView() {
        let offset = backgroundViewBorder + fillViewInset
        fillView.frame = backgroundView.frame.insetBy(dx: offset, dy: offset)
        fillView.backgroundColor = fillViewBackgroundColor
        fillView.layer.cornerRadius = cornerRadiusFor(view: fillView)
    }
    
    private func cornerRadiusFor(view: UIView) -> CGFloat {
        return view.frame.height / 2 * 0.7
    }
}
